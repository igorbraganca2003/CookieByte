//
//  CartCard.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 23/05/24.
//

import UIKit

class CartCard: UIView {
    
    var index: Int = 0
    
    var quantity = 1 {
        didSet {
            qntLabel.text = "\(quantity)"
        }
    }
    
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
    
    private let trash: UIButton = {
        let trash = UIButton()
        let trashImage = UIImage(systemName: "trash")
        trash.setImage(trashImage, for: .normal)
        trash.isUserInteractionEnabled = true
        trash.translatesAutoresizingMaskIntoConstraints = false
        return trash
    }()
    
    private lazy var qntStack: UIStackView = {
        let qnt = UIStackView(arrangedSubviews: [remove, qntLabel, plus])
        qnt.axis = .horizontal
        qnt.distribution = .equalSpacing
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
        trash.addTarget(self, action: #selector(removeItem), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func removeItem() {
        guard index < Order.shared.orders.count else {
            return // Evita acessar índices inválidos
        }
        Order.shared.removeOrder(at: index)
    }
    
    @objc func incrementQuantity() {
        quantity += 1
        qntLabel.text = "\(quantity)"
        print(quantity)
    }
    
    @objc func decrementQuantity() {
        if quantity > 1 {
            quantity -= 1
        }
        qntLabel.text = "\(quantity)"
        print(quantity)
    }
    
    func config(with order: OrderModel, atIndex index: Int) {
        label.text = order.cookie
        price.text = "R$ \(order.price)"
        if let quantity = order.qnt {
            self.quantity = quantity
            qntLabel.text = "\(quantity)"
        }
        image.image = order.pic
        image.backgroundColor = order.color
        self.index = index
    }


    
    
    // Func
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
            
            qntStack.widthAnchor.constraint(equalTo: bottomStack.widthAnchor, multiplier: 0.45),
            qntStack.trailingAnchor.constraint(equalTo: vStack.trailingAnchor),
            
            remove.heightAnchor.constraint(equalTo: qntStack.heightAnchor, constant: 1)
        ])
    }
}

#Preview {
    return CartCard()
}
