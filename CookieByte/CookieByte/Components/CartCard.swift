//
//  CartCard.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 23/05/24.
//

import UIKit

class CartCard: UIView {
    
    private lazy var cartCard: UIStackView = {
        let card = UIStackView(arrangedSubviews: [image, vStack, qntStack])
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
        let image = UIImage(named: "CookieM")
        imageView.image = image
        imageView.backgroundColor = UIColor(named: "Cookie2Back")
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let price: UILabel = {
        let price = UILabel()
        price.textAlignment = .left
        price.font = UIFont.systemFont(ofSize: 12, weight: .medium)
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
        remove.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        remove.setTitleColor(UIColor.black, for: .normal)
        remove.addTarget(self, action: #selector(decrementQuantity), for: .touchUpInside)
        remove.translatesAutoresizingMaskIntoConstraints = false
        return remove
    }()
    
    private let qntLabel: UILabel = {
        let qnt = UILabel()
        qnt.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        qnt.text = "1" // Valor inicial
        qnt.translatesAutoresizingMaskIntoConstraints = false
        return qnt
    }()
    
    private let plus: UIButton = {
        let plus = UIButton()
        plus.setTitle("+", for: .normal)
        plus.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        plus.setTitleColor(UIColor.accent, for: .normal)
        plus.addTarget(self, action: #selector(incrementQuantity), for: .touchUpInside)
        plus.translatesAutoresizingMaskIntoConstraints = false
        return plus
    }()
    
    
    // Body
    override func draw(_ rect: CGRect) {
        setCard()
    }
    
    // Func
    func setCard(){
        self.addSubview(cartCard)
        
        NSLayoutConstraint.activate([
            cartCard.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cartCard.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cartCard.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            cartCard.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            image.leadingAnchor.constraint(equalTo: cartCard.leadingAnchor),
            image.widthAnchor.constraint(equalTo: cartCard.widthAnchor, constant: -190),
            image.heightAnchor.constraint(equalTo: cartCard.heightAnchor),
            
            vStack.widthAnchor.constraint(equalTo: cartCard.widthAnchor, multiplier: 0.35),
            vStack.leftAnchor.constraint(equalTo: cartCard.leftAnchor, constant: 113),
            vStack.topAnchor.constraint(equalTo: cartCard.topAnchor, constant: -15),
            vStack.heightAnchor.constraint(lessThanOrEqualTo: cartCard.heightAnchor),
        ])
    }
    
    //Funções que aumentam e diminui a quantidade
    var quantity = 1 {
        didSet {
            qntLabel.text = "\(quantity)"
        }
    }
    
    @objc private func incrementQuantity() {
        quantity += 1
    }
    
    @objc private func decrementQuantity() {
        if quantity > 1 {
            quantity -= 1
        }
    }
    
    func config(with cookie: CookiesModel) {
        label.text = cookie.cookieName
        price.text = String(format: "R$ %.2f",cookie.price)
    }
    
    func qntModel(with order: OrderModel) {
        quantity = order.qnt
    }
}

#Preview {
    return CartCard()
}
