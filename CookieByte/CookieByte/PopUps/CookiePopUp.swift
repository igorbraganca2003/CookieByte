//
//  CookiePopUp.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 20/05/24.
//

import UIKit

class CookiePopUp: UIView {
    
    // Icone de carrinho
    let delegate: IconCartDelegate = IconCartDelegate()
    var viewController: HomeViewController?
    
    var currentCookie: CookiesModel?
    
    private lazy var VStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [imageCookie, roundButton, HStack, priceLabel, descLabel, buttonStack, ])
        vStack.axis = .vertical
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private let backContainer: UIView = {
        let backContainer = UIView()
        backContainer.backgroundColor = .gray.withAlphaComponent(0.7)
        backContainer.translatesAutoresizingMaskIntoConstraints = false
        return backContainer
    }()
    
    private let container: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.borderWidth = 6
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let roundButton: RoundButton = {
        let round = RoundButton()
        round.setButtonType(type: .close)
        round.translatesAutoresizingMaskIntoConstraints = false
        return round
    }()
    
    let imageCookie: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var HStack: UIStackView = {
        let hStack = UIStackView(arrangedSubviews: [label])
        hStack.axis = .horizontal
        hStack.spacing = 10
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Cookie M&M's"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let heartButton: UIButton = {
        let heart = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        let buttonImage = UIImage(systemName: "heart", withConfiguration: config)
        heart.setImage(buttonImage, for: .normal)
        heart.tintColor = .black
        heart.translatesAutoresizingMaskIntoConstraints = false
        //        heart.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        return heart
    }()
    
    let priceLabel: UILabel = {
        let price = UILabel()
        price.text = "R$ 4.00"
        price.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        price.textColor = UIColor(named: "AccentColor")
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    let descLabel: UITextView = {
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
    
    private let buyButton: MainButtons = {
        let mainButton = MainButtons()
        mainButton.setButton(type: .buy)
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        return mainButton
    }()
    
    private let addCartButton: MainButtons = {
        let cartButton = MainButtons()
        cartButton.setButton(type: .addCart)
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        return cartButton
    }()
    
    private lazy var buttonStack: UIStackView = {
        let buttonStack = UIStackView(arrangedSubviews: [addCartButton, buyButton])
        buttonStack.axis = .vertical
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        return buttonStack
    }()
    
    
    // Body
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = UIScreen.main.bounds
        
        addUI()
        
        CookieController.animateIn(view: self, container: container)
        
        addCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        buyButton.addTarget(self, action: #selector(payButton), for: .touchUpInside)
        roundButton.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
        
        delegate.uiView = self
        delegate.viewController = self.viewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func animateOut() {
        CookieController.animateOut(view: self, container: container)
    }
    
    @objc func addToCart(){
        CookieController.addToCart(from: self)
    }
    
    @objc func payButton() {
        CookieController.payButtonTapped(from: self)
    }
    
    func configure(with cookie: CookiesModel) {
        currentCookie = cookie
        
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
        
//        CookieController.updateHeartButton(self)
    }
    
    
    
    
    func addUI() {
        self.addSubview(backContainer)
        self.addSubview(container)
        container.addSubview(VStack)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateOut))
        backContainer.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            backContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backContainer.widthAnchor.constraint(equalTo: self.widthAnchor),
            backContainer.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 100),
            
            container.centerYAnchor.constraint(equalTo: backContainer.centerYAnchor),
            container.centerXAnchor.constraint(equalTo: backContainer.centerXAnchor),
            container.widthAnchor.constraint(equalTo: backContainer.widthAnchor, multiplier: 0.85),
            container.heightAnchor.constraint(equalToConstant: 700),
            
            VStack.topAnchor.constraint(equalTo: container.topAnchor),
            VStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            VStack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            VStack.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            roundButton.topAnchor.constraint(equalTo: container.topAnchor, constant: -220),
            roundButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 275),
            
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
            
            buttonStack.topAnchor.constraint(equalTo: descLabel.bottomAnchor),
            buttonStack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            addCartButton.topAnchor.constraint(equalTo: buttonStack.topAnchor, constant: 50),
            addCartButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -6),
            
            buyButton.topAnchor.constraint(equalTo: buttonStack.topAnchor, constant: 90)
        ])
    }
}

#Preview(){
    return CookiePopUp()
}
