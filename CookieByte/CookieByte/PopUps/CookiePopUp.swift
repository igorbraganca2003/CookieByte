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
        let vStack = UIStackView(arrangedSubviews: [imageCookie, roundButton, HStack, descLabel, warning, buttonStack])
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
        let hStack = UIStackView(arrangedSubviews: [label, priceLabel])
        hStack.axis = .horizontal
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()

    let label: UILabel = {
        let label = UILabel()
        label.text = "Cookie M&M's"
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
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

    private lazy var buttonStack: UIStackView = {
        let buttonStack = UIStackView(arrangedSubviews: [buyButton])
        buttonStack.axis = .vertical
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        return buttonStack
    }()

    private lazy var warning: UIStackView = {
        let warning = UIStackView(arrangedSubviews: [SrChocolato, labelWarning])
        warning.axis = .horizontal
//        warning.layer.borderWidth = 1
        warning.translatesAutoresizingMaskIntoConstraints = false
        return warning
    }()

    private let SrChocolato: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Sr.ChocolatoYellow")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let labelWarning: UILabel = {
        let label = UILabel()
        label.text = "Verifique a disponibilidade dos produtos antes de realizar a compra!"
        label.textColor = UIColor(named: "YellowCookie")
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Body
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.frame = UIScreen.main.bounds

        addUI()

        CookieController.animateIn(view: self, container: container)

        buyButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
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

    @objc func addToCart() {
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
            HStack.topAnchor.constraint(equalTo: imageCookie.centerYAnchor, constant: 150),
            HStack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.13),

            label.widthAnchor.constraint(equalTo: HStack.widthAnchor, multiplier: 0.6),
            label.topAnchor.constraint(equalTo: HStack.topAnchor),

            priceLabel.topAnchor.constraint(equalTo: HStack.topAnchor, constant: 15),
            priceLabel.widthAnchor.constraint(equalTo: HStack.widthAnchor, multiplier: 0.35),
            priceLabel.heightAnchor.constraint(equalTo: HStack.heightAnchor, constant: -70),

            descLabel.topAnchor.constraint(equalTo: HStack.bottomAnchor, constant: 10),
            descLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            descLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),

            warning.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            warning.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            warning.topAnchor.constraint(equalTo: descLabel.topAnchor, constant: 110),
            warning.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.12),
            
            SrChocolato.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.2),

            labelWarning.widthAnchor.constraint(equalTo: warning.widthAnchor, multiplier: 0.7),
            
            buttonStack.topAnchor.constraint(equalTo: warning.bottomAnchor, constant: 0),
            buttonStack.centerXAnchor.constraint(equalTo: container.centerXAnchor),

            buyButton.topAnchor.constraint(equalTo: buttonStack.topAnchor, constant: 0),
            buyButton.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: -3),
        ])
    }
}

#Preview(){
    return CookiePopUp()
}
