//
//  CookiePopUp.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 20/05/24.
//

import UIKit
import ObjectiveC

class CookiePopUp: UIView {
    
    private lazy var VStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [imageCookie, HStack, priceLabel, descLabel, buttonStack])
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private let container: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.borderWidth = 6
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let imageCookie: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let roundButton: UIView = {
        let round = RoundButton()
        round.setButtonType(type: .close)
        round.translatesAutoresizingMaskIntoConstraints = false
        round.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        return round
    }()
    
    private lazy var HStack: UIStackView = {
        let hStack = UIStackView(arrangedSubviews: [label, heartButton])
        hStack.axis = .horizontal
        hStack.spacing = 10
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Cookie M&M's"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heartButton: UIButton = {
        let heart = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        let buttonImage = UIImage(systemName: "heart", withConfiguration: config)
        heart.setImage(buttonImage, for: .normal)
        heart.tintColor = .black
        return heart
    }()
    
    private let priceLabel: UILabel = {
        let price = UILabel()
        price.text = "R$ 4.00"
        price.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        price.textColor = UIColor(named: "AccentColor")
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    private let descLabel: UITextView = {
        let desc = UITextView()
        desc.text = "Cookies tradicionais, contém: Açúcar, Açúcar Mascavo, Sal, Manteiga, Ovos, Farinha, Baunilha, Gotas de Chocolate, Confeitos M&M's."
        desc.font = UIFont.systemFont(ofSize: 16)
        desc.textColor = .black
        desc.backgroundColor = .clear
        desc.isEditable = false
        desc.isScrollEnabled = false
        desc.translatesAutoresizingMaskIntoConstraints = false
        return desc
    }()
    
    private let buyButton: UIView = {
        let mainButton = MainButtons(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        mainButton.setButton(type: .buy)
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        return mainButton
    }()
    
    private let addCartButton: UIButton = {
        let cartButton = UIButton()
    
        cartButton.setTitle("buy", for: .normal)
        cartButton.isUserInteractionEnabled = true
        cartButton.setTitleColor(.accent, for: .normal)
        cartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        return cartButton
    }()
    
    private lazy var buttonStack: UIStackView = {
        let buttonStack = UIStackView(arrangedSubviews: [addCartButton, buyButton])
        buttonStack.axis = .vertical
        buttonStack.spacing = 10
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        return buttonStack
    }()
    
    // Body
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.backgroundColor = .gray.withAlphaComponent(0.7)
        self.frame = UIScreen.main.bounds
        
        addUI()
        animateIn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func animateOut(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc func animateIn(){
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    func configure(with cookie: CookiesModel) {
        if let originalImage = UIImage(named: cookie.pic) {
            let newSize = CGSize(width: originalImage.size.width * 0.4, height: originalImage.size.height * 0.4)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            originalImage.draw(in: CGRect(origin: .zero, size: newSize))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let resizedImage = resizedImage {
                imageCookie.image = resizedImage
            } else {
                print("Erro ao redimensionar a imagem")
                imageCookie.image = originalImage
            }
        } else {
            print("Erro ao carregar a imagem original")
            imageCookie.image = nil
        }
        
        label.text = cookie.cookieName
        priceLabel.text = String(format: "R$ %.2f", cookie.price)
        descLabel.text = cookie.description
        imageCookie.backgroundColor = cookie.color
    }
    
    @objc func addToCart() {
        guard let cookieName = label.text,
              let priceText = priceLabel.text,
              let price = Float(priceText.replacingOccurrences(of: "R$ ", with: "").replacingOccurrences(of: ",", with: ".")) else {
            return
        }
        
        let newOrder = OrderModel(user: nil, cookie: cookieName, date: Date(), price: price, qnt: 1, status: true)
        Order.shared.addOrder(newOrder)
        print("Pedido adicionado: \(newOrder)")
    }
    
    // Functions
    func addUI() {
        self.addSubview(container)
        container.addSubview(VStack)
        container.addSubview(roundButton)
        
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            container.heightAnchor.constraint(equalToConstant: 700),
            
            VStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            VStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            VStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            VStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            
            roundButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -60),
            roundButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 40),
            
            imageCookie.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.4),
            imageCookie.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            imageCookie.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            imageCookie.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            
            HStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            HStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            HStack.topAnchor.constraint(equalTo: imageCookie.centerYAnchor, constant: 160),
            
            priceLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            
            descLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            descLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            descLabel.topAnchor.constraint(equalTo: priceLabel.centerYAnchor, constant: 30),
            
            buttonStack.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 0),
            addCartButton.topAnchor.constraint(equalTo: buttonStack.topAnchor, constant: 40),
            buyButton.topAnchor.constraint(equalTo: addCartButton.centerYAnchor, constant: 45),
        ])
    }
}

#Preview(){
    return CookiePopUp()
}
