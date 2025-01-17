////
////  CookiePopUp.swift
////  CookieByte
////
////  Created by Igor Bragança Toledo on 20/05/24.
////
//
//import UIKit
//
//class CookiePopUp: UIView {
//
//    // Icone de carrinho
//    let delegate: IconCartDelegate = IconCartDelegate()
//    var viewController: HomeViewController?
//    
//    private var currentCookie: CookiesModel?
//    
//    private lazy var VStack: UIStackView = {
//        let vStack = UIStackView(arrangedSubviews: [roundButton, imageCookie, HStack, priceLabel, descLabel, buttonStack])
//        vStack.axis = .vertical
//        vStack.spacing = 10
//        vStack.translatesAutoresizingMaskIntoConstraints = false
//        return vStack
//    }()
//    
//    private let backContainer: UIView = {
//        let backContainer = UIView()
//        backContainer.backgroundColor = .gray.withAlphaComponent(0.7)
//        backContainer.translatesAutoresizingMaskIntoConstraints = false
//        return backContainer
//    }()
//    
//    private let container: UIView = {
//        let container = UIView()
//        container.backgroundColor = .white
//        container.layer.borderColor = UIColor.black.cgColor
//        container.layer.borderWidth = 6
//        container.translatesAutoresizingMaskIntoConstraints = false
//        return container
//    }()
//    
//    private let imageCookie: UIImageView = {
//        let imageView = UIImageView()
//        imageView.layer.borderWidth = 6
//        imageView.layer.borderColor = UIColor.black.cgColor
//        imageView.contentMode = .center
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    private let roundButton: RoundButton = {
//        let round = RoundButton()
//        round.setButtonType(type: .close)
//        round.translatesAutoresizingMaskIntoConstraints = false
//        return round
//    }()
//
//    private lazy var HStack: UIStackView = {
//        let hStack = UIStackView(arrangedSubviews: [label])
//        hStack.axis = .horizontal
//        hStack.spacing = 10
//        hStack.translatesAutoresizingMaskIntoConstraints = false
//        return hStack
//    }()
//    
//    private let label: UILabel = {
//        let label = UILabel()
//        label.text = "Cookie M&M's"
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let heartButton: UIButton = {
//        let heart = UIButton()
//        let config = UIImage.SymbolConfiguration(pointSize: 24)
//        let buttonImage = UIImage(systemName: "heart", withConfiguration: config)
//        heart.setImage(buttonImage, for: .normal)
//        heart.tintColor = .black
//        heart.translatesAutoresizingMaskIntoConstraints = false
//        heart.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
//        return heart
//    }()
//    
//    private let priceLabel: UILabel = {
//        let price = UILabel()
//        price.text = "R$ 4.00"
//        price.font = UIFont.systemFont(ofSize: 22, weight: .bold)
//        price.textColor = UIColor(named: "AccentColor")
//        price.translatesAutoresizingMaskIntoConstraints = false
//        return price
//    }()
//    
//    private let descLabel: UITextView = {
//        let desc = UITextView()
//        desc.text = "Cookies tradicionais, contém: Açúcar, Açúcar Mascavo, Sal, Manteiga, Ovos, Farinha, Baunilha, Gotas de Chocolate, Confeitos M&M's."
//        desc.font = UIFont.systemFont(ofSize: 16)
//        desc.textColor = .black
//        desc.backgroundColor = .clear
//        desc.isEditable = false
//        desc.isScrollEnabled = false
//        desc.translatesAutoresizingMaskIntoConstraints = false
//        return desc
//    }()
//    
//    private let buyButton: MainButtons = {
//        let mainButton = MainButtons()
//        mainButton.setButton(type: .buy)
//        mainButton.translatesAutoresizingMaskIntoConstraints = false
//        return mainButton
//    }()
//    
//    private let addCartButton: MainButtons = {
//        let cartButton = MainButtons()
//        cartButton.setButton(type: .addCart)
//        cartButton.translatesAutoresizingMaskIntoConstraints = false
//        return cartButton
//    }()
//    
//    private lazy var buttonStack: UIStackView = {
//        let buttonStack = UIStackView(arrangedSubviews: [addCartButton, buyButton])
//        buttonStack.axis = .vertical
//        buttonStack.translatesAutoresizingMaskIntoConstraints = false
//        return buttonStack
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.frame = UIScreen.main.bounds
//        
//        addUI()
//        animateIn()
//        
//        addCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
//        buyButton.addTarget(self, action: #selector(payButton), for: .touchUpInside)
//        roundButton.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
//
//        delegate.uiView = self
//        delegate.viewController = self.viewController
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    @objc fileprivate func animateOut() {
//        print("AnimateOut called") // Adicione um log aqui para depuração
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, animations: {
//            self.container.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
//            self.alpha = 0
//        }) { (complete) in
//            if complete {
//                self.removeFromSuperview()
//            }
//        }
//    }
//    
//    @objc func animateIn() {
//        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
//        self.alpha = 0
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, animations: {
//            self.container.transform = .identity
//            self.alpha = 1
//        })
//    }
//    
//    func configure(with cookie: CookiesModel) {
//        currentCookie = cookie
//        
//        if let originalImage = UIImage(named: cookie.pic) {
//            let newSize = CGSize(width: originalImage.size.width * 0.4, height: originalImage.size.height * 0.4)
//            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
//            originalImage.draw(in: CGRect(origin: .zero, size: newSize))
//            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            if let resizedImage = resizedImage {
//                imageCookie.image = resizedImage
//            } else {
//                print("Erro ao redimensionar a imagem")
//                imageCookie.image = originalImage
//            }
//        } else {
//            print("Erro ao carregar a imagem original")
//            imageCookie.image = nil
//        }
//        
//        label.text = cookie.cookieName
//        priceLabel.text = String(format: "R$ %.2f", cookie.price)
//        descLabel.text = cookie.description
//        imageCookie.backgroundColor = cookie.color
//        
//        updateHeartButton()
//    }
//    
//    @objc func toggleFavorite() {
//        guard var cookie = currentCookie else { return }
//        cookie.isFavorite.toggle()
//        currentCookie = cookie
//        updateHeartButton()
//    }
//    
//    func updateHeartButton() {
//        guard let cookie = currentCookie else { return }
//        let config = UIImage.SymbolConfiguration(pointSize: 24)
//        let buttonImageName = cookie.isFavorite ? "heart.fill" : "heart"
//        let buttonImage = UIImage(systemName: buttonImageName, withConfiguration: config)
//        heartButton.setImage(buttonImage, for: .normal)
//    }
//    
//    @objc func payButton() {
//        let popup = PixPopUp()
//        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
//            window.addSubview(popup)
//            popup.animateIn()
//        }
//        print("Botão de compra pressionado")
//    }
//    
//    @objc func addToCart() {
//        guard let cookieName = label.text,
//              let cookieImage = imageCookie.image,
//              let cookieBack = imageCookie.backgroundColor,
//              let priceText = priceLabel.text,
//              let price = Float(priceText.replacingOccurrences(of: "R$ ", with: "").replacingOccurrences(of: ",", with: ".")) else {
//            return
//        }
//        
//        let newOrder = OrderModel(user: nil, cookie: cookieName, date: Date(), price: price, qnt: 1, pic: cookieImage, status: true, color: cookieBack)
//        Order.shared.addOrder(newOrder)
//        print("Pedido adicionado: \(newOrder)")
//    
//        let popup = CartPopUp()
//        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
//            window.addSubview(popup)
//            popup.animateIn()
//        }
//        
//        self.removeFromSuperview()
//    }
//    
//    func addUI() {
//        self.addSubview(backContainer)
//        self.addSubview(container)
//        container.addSubview(VStack)
//        
//        // Não precisamos adicionar o roundButton duas vezes
//        // VStack.addSubview(roundButton) -- Remover esta linha
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateOut))
//        backContainer.addGestureRecognizer(tapGesture)
//        
//        NSLayoutConstraint.activate([
//            backContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            backContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            backContainer.widthAnchor.constraint(equalTo: self.widthAnchor),
//            backContainer.heightAnchor.constraint(equalTo: self.heightAnchor),
//            
//            container.centerYAnchor.constraint(equalTo: backContainer.centerYAnchor),
//            container.centerXAnchor.constraint(equalTo: backContainer.centerXAnchor),
//            container.widthAnchor.constraint(equalTo: backContainer.widthAnchor, multiplier: 0.85),
//            container.heightAnchor.constraint(equalToConstant: 700),
//            
//            VStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
//            VStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
//            VStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
//            VStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
//            
//            roundButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20), // Ajustando a posição do roundButton
//            roundButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
//            
//            imageCookie.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.4),
//            imageCookie.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
//            imageCookie.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
//            imageCookie.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
//            
//            HStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
//            HStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
//            HStack.topAnchor.constraint(equalTo: imageCookie.centerYAnchor, constant: 160),
//            
//            priceLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
//            priceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
//            
//            descLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
//            descLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
//            descLabel.topAnchor.constraint(equalTo: priceLabel.centerYAnchor, constant: 30),
//            
//            buttonStack.topAnchor.constraint(equalTo: descLabel.bottomAnchor),
//            buttonStack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
//            
//            addCartButton.topAnchor.constraint(equalTo: buttonStack.topAnchor, constant: 10),
//            addCartButton.centerYAnchor.constraint(equalTo: addCartButton.centerYAnchor),
//            
//            buyButton.topAnchor.constraint(equalTo: buttonStack.topAnchor, constant: 100),
//            buyButton.centerYAnchor.constraint(equalTo: buyButton.centerYAnchor)
//        ])
//    }
//}
//
//
//#Preview {
//    CookiePopUp()
//}
//
