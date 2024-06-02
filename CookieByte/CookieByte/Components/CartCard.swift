//
//  CartCard.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 23/05/24.
//

import UIKit

class CartCard: UIView {
    
    private lazy var cartCard: UIStackView = {
        let card = UIStackView(arrangedSubviews: [image, vStack])
        card.axis = .horizontal
        card.alignment = .fill
        card.spacing = 10
        card.backgroundColor = .white
        card.layer.borderColor = UIColor.black.cgColor
        card.layer.borderWidth = 6
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [label, price])
        vStack.axis = .vertical
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    private lazy var qntStack: UIStackView = {
        let qnt = UIStackView(arrangedSubviews: [remove, qntLabel, plus])
        qnt.axis = .horizontal
        qnt.distribution = .equalSpacing
        qnt.translatesAutoresizingMaskIntoConstraints = false
        return qnt
    }()
    
    private let remove: UIButton = {
        let remove = UIButton()
        remove.setTitle("-", for: .normal)
        remove.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        remove.setTitleColor(UIColor.accent, for: .normal)
        remove.addTarget(self, action: #selector(CookieController.decrementQuantity), for: .touchUpInside)
        remove.translatesAutoresizingMaskIntoConstraints = false
        return remove
    }()
    
    let qntLabel: UILabel = {
        let qnt = UILabel()
        qnt.textColor = .black
        qnt.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        qnt.text = "1" 
        qnt.translatesAutoresizingMaskIntoConstraints = false
        return qnt
    }()
    
    private let plus: UIButton = {
        let plus = UIButton()
        plus.setTitle("+", for: .normal)
        plus.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        plus.setTitleColor(UIColor.accent, for: .normal)
        plus.addTarget(self, action: #selector(CookieController.incrementQuantity), for: .touchUpInside)
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
    
    func config(with order: OrderModel) {
        label.text = order.cookie
        price.text = "R$ \(order.price)"
        CookieController().quantity = order.qnt
        image.image = order.pic
        image.backgroundColor = order.color
        
    }
    
    
    // Func
    func setCard() {
        self.addSubview(cartCard)
        cartCard.addSubview(qntStack)
        
        NSLayoutConstraint.activate([
            cartCard.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cartCard.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cartCard.heightAnchor.constraint(equalTo: self.heightAnchor),
            cartCard.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.15),
            
            image.leadingAnchor.constraint(equalTo: cartCard.leadingAnchor),
            image.widthAnchor.constraint(equalTo: cartCard.widthAnchor, constant: -190),
            image.heightAnchor.constraint(equalTo: cartCard.heightAnchor),
            
            vStack.widthAnchor.constraint(equalTo: cartCard.widthAnchor, multiplier: 0.35),
            vStack.leftAnchor.constraint(equalTo: cartCard.leftAnchor, constant: 113),
            vStack.topAnchor.constraint(equalTo: cartCard.topAnchor, constant: -15),
            vStack.heightAnchor.constraint(lessThanOrEqualTo: cartCard.heightAnchor),
            
            qntStack.leadingAnchor.constraint(equalTo: cartCard.leadingAnchor, constant: 200),
            qntStack.trailingAnchor.constraint(equalTo: cartCard.trailingAnchor, constant: -10),
            qntStack.centerYAnchor.constraint(equalTo: cartCard.centerYAnchor)
        ])
    }
}

#Preview {
    return CartCard()
}
