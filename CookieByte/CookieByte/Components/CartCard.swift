//
//  CartCard.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 23/05/24.
//

// CartCard.swift
import UIKit

class CartCard: UIView {

    var quantity = 1 {
        didSet {
            qntLabel.text = "\(quantity)"
            updatePrice()
        }
    }

    var orderIndex: Int?

    private lazy var trash: UIButton = {
        let trash = UIButton()
        let trashImage = UIImage(systemName: "trash")
        trash.setImage(trashImage, for: .normal)
        trash.isUserInteractionEnabled = true
        trash.translatesAutoresizingMaskIntoConstraints = false
        trash.addTarget(self, action: #selector(removeItem), for: .touchUpInside)
        return trash
    }()

    private lazy var cartCard: UIStackView = {
        let card = UIStackView(arrangedSubviews: [image, vStack])
        card.axis = .horizontal
        card.alignment = .fill
        card.spacing = 10
        card.backgroundColor = .white
        card.layer.borderColor = UIColor.black.cgColor
        card.layer.borderWidth = 6
        card.translatesAutoresizingMaskIntoConstraints = false
        card.isUserInteractionEnabled = true
        return card
    }()

    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [topStack, bottomStack])
        vStack.axis = .vertical
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.isUserInteractionEnabled = true
        return vStack
    }()

    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let price: UILabel = {
        let price = UILabel()
        price.textAlignment = .left
        price.textColor = .black
        price.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        price.numberOfLines = 0
        price.lineBreakMode = .byWordWrapping
        price.isUserInteractionEnabled = true
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()

    private lazy var topStack: UIStackView = {
        let tStack = UIStackView(arrangedSubviews: [label, trash])
        tStack.axis = .horizontal
        tStack.isUserInteractionEnabled = true
        tStack.translatesAutoresizingMaskIntoConstraints = false
        return tStack
    }()

    private lazy var bottomStack: UIStackView = {
        let bStack = UIStackView(arrangedSubviews: [price, qntStack])
        bStack.axis = .horizontal
        bStack.isUserInteractionEnabled = true
        bStack.translatesAutoresizingMaskIntoConstraints = false
        return bStack
    }()

    private lazy var qntStack: UIStackView = {
        let qnt = UIStackView(arrangedSubviews: [remove, qntLabel, plus])
        qnt.axis = .horizontal
        qnt.distribution = .fill
        qnt.isUserInteractionEnabled = true
        qnt.translatesAutoresizingMaskIntoConstraints = false
        return qnt
    }()

    private let remove: UIButton = {
        let remove = UIButton()
        remove.setTitle("-", for: .normal)
        remove.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        remove.setTitleColor(UIColor.accent, for: .normal)
        remove.addTarget(self, action: #selector(decrementQuantity), for: .touchUpInside)
        remove.isUserInteractionEnabled = true
        remove.translatesAutoresizingMaskIntoConstraints = false
        return remove
    }()

    let qntLabel: UILabel = {
        let qnt = UILabel()
        qnt.textColor = .black
        qnt.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        qnt.isUserInteractionEnabled = true
        qnt.translatesAutoresizingMaskIntoConstraints = false
        return qnt
    }()

    private let plus: UIButton = {
        let plus = UIButton()
        plus.setTitle("+", for: .normal)
        plus.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        plus.setTitleColor(UIColor.accent, for: .normal)
        plus.addTarget(self, action: #selector(incrementQuantity), for: .touchUpInside)
        plus.isUserInteractionEnabled = true
        plus.translatesAutoresizingMaskIntoConstraints = false
        return plus
    }()

    // Body
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCard()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func removeItem() {
        guard let index = orderIndex else { return }
        Order.shared.removeOrder(at: index)
        print("Item removido no índice \(index)")
    }

    @objc func incrementQuantity() {
        guard let orderIndex = orderIndex else { return }
        Order.shared.orders[orderIndex].qnt += 1
        quantity = Order.shared.orders[orderIndex].qnt
        NotificationCenter.default.post(name: NSNotification.Name("OrderUpdated"), object: nil)
    }

    @objc func decrementQuantity() {
        guard let orderIndex = orderIndex else { return }
        if Order.shared.orders[orderIndex].qnt > 1 {
            Order.shared.orders[orderIndex].qnt -= 1
            quantity = Order.shared.orders[orderIndex].qnt
            NotificationCenter.default.post(name: NSNotification.Name("OrderUpdated"), object: nil)
        }
    }

    private func updatePrice() {
        guard let orderIndex = orderIndex, orderIndex < Order.shared.orders.count else { return }
        let order = Order.shared.orders[orderIndex]
        let totalPrice = order.price * Double(order.qnt)
        price.text = String(format: "R$ %.2f", totalPrice)
    }

    func config(with order: OrderModel, index: Int) {
        orderIndex = index
        image.image = order.pic
        label.text = order.cookie
        price.text = String(format: "R$ %.2f", order.price * Double(order.qnt))
        quantity = order.qnt
        qntLabel.text = "\(order.qnt)"
        image.backgroundColor = order.color

        // Desabilitar botões se order.isPrize for true
        if order.isPrize {
            remove.isEnabled = false
            plus.isEnabled = false
            remove.alpha = 0.5
            plus.alpha = 0.5
        } else {
            remove.isEnabled = true
            plus.isEnabled = true
            remove.alpha = 1.0
            plus.alpha = 1.0
        }

        print("Configuração do card: \(order)")
        print("Remove isEnabled: \(remove.isEnabled), Plus isEnabled: \(plus.isEnabled)")
    }

    func setCard() {
        self.addSubview(cartCard)
        cartCard.addSubview(vStack)

        NSLayoutConstraint.activate([
            cartCard.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cartCard.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cartCard.heightAnchor.constraint(equalTo: self.heightAnchor),
            cartCard.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.15),

            image.leadingAnchor.constraint(equalTo: cartCard.leadingAnchor),
            image.widthAnchor.constraint(equalTo: cartCard.widthAnchor, constant: -190),
            image.heightAnchor.constraint(equalTo: cartCard.heightAnchor),

            vStack.widthAnchor.constraint(equalTo: cartCard.widthAnchor, multiplier: 0.56),
            vStack.leftAnchor.constraint(equalTo: cartCard.leftAnchor, constant: 112),

            topStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            topStack.heightAnchor.constraint(equalTo: vStack.heightAnchor, multiplier: 0.6),

            label.widthAnchor.constraint(equalTo: topStack.widthAnchor, multiplier: 0.8),

            trash.trailingAnchor.constraint(equalTo: vStack.trailingAnchor),

            bottomStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            bottomStack.heightAnchor.constraint(equalTo: vStack.heightAnchor, multiplier: 0.5),

            qntStack.widthAnchor.constraint(equalTo: bottomStack.widthAnchor, multiplier: 0.5),
            qntStack.trailingAnchor.constraint(equalTo: vStack.trailingAnchor),

            remove.heightAnchor.constraint(equalTo: qntStack.heightAnchor, constant: 1)
        ])
    }
}

#Preview {
    return CartCard()
}
