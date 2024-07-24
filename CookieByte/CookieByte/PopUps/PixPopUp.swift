//
//  CookiePopUp.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 20/05/24.
//

import UIKit

class PixPopUp: UIView {
    
    private lazy var VStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [HStack, imageView, priceLabel, pixLabelBack, copyButton, buttonStack])
        vStack.axis = .vertical
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private lazy var HStack: UIStackView = {
        let hStack = UIStackView(arrangedSubviews: [backButton, roundButton])
        hStack.axis = .horizontal
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
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
        round.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
        round.translatesAutoresizingMaskIntoConstraints = false
        return round
    }()
    
    private let backButton: RoundButton = {
        let round = RoundButton()
        round.setButtonType(type: .back)
        round.addTarget(self, action: #selector(backToCart), for: .touchUpInside)
        round.isUserInteractionEnabled = true
        round.translatesAutoresizingMaskIntoConstraints = false
        return round
    }()
    
    private let imageView: UIImageView = {
        let pix = UIImageView()
        pix.translatesAutoresizingMaskIntoConstraints = false
        return pix
    }()
    
    let priceLabel: UILabel = {
        let price = UILabel()
        price.textColor = UIColor(named: "GreenCookie")
        price.textAlignment = .center
        price.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    private let pixLabelBack: UIView = {
        let back = UIView()
        back.backgroundColor = UIColor(named: "LightGrayCookie")
        back.translatesAutoresizingMaskIntoConstraints = false
        return back
    }()
    
    private let pixLabel: UILabel = {
        let key = UILabel()
        key.textAlignment = .center
        key.textColor = .black
        key.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        key.translatesAutoresizingMaskIntoConstraints = false
        key.numberOfLines = 1
        return key
    }()
    
    private let copyButton: UIButton = {
        let copy = UIButton()
        let title = "Copiar Código Pix"
        
        let attributedTitle = NSAttributedString(string: title, attributes: [
            .foregroundColor: UIColor(named: "GreenCookie") ?? .green,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        copy.setAttributedTitle(attributedTitle, for: .normal)
        copy.addTarget(self, action: #selector(copyPixCode), for: .touchUpInside)
        copy.translatesAutoresizingMaskIntoConstraints = false
        return copy
    }()
    
    private let ConfirmButton: MainButtons = {
        let confirm = MainButtons()
        confirm.setButton(type: .confirmPay)
        confirm.translatesAutoresizingMaskIntoConstraints = false
        return confirm
    }()
    
    private lazy var buttonStack: UIStackView = {
        let buttonStack = UIStackView(arrangedSubviews: [ConfirmButton])
        buttonStack.axis = .vertical
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        return buttonStack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        
        CookieController.animateIn(view: self, container: container)
        CookieController.updateTotalPrice(label: priceLabel)
        
        ConfirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        roundButton.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
        
        addUI()
        setPix()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func animateOut() {
        CookieController.animateOut(view: self, container: container)
    }
    
    @objc fileprivate func confirmButtonTapped() {
        CookieController.payConfirmed(from: self)
    }
    
    @objc fileprivate func copyPixCode() {
        UIPasteboard.general.string = pixLabel.text
        let alert = UIAlertController(title: "Copiado", message: "Código Pix copiado para a área de transferência", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let viewController = self.window?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc fileprivate func backToCart() {
        let popup = CartPopUp()
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(popup)
            CookieController.animateIn(view: popup, container: popup)
        }
        print("botão voltar clicado")
        popup.removeSuperView(from: self)
    }
    
    func setPix() {
        let totalPrice = Order.shared.orders.reduce(0) { $0 + ($1.price * Double($1.qnt)) }
        
        var pixType: PixEnum
        
        switch totalPrice {
        case 4:
            pixType = .four
        case 8:
            pixType = .eight
        case 12:
            pixType = .twelve
        case 16:
            pixType = .sixteen
        case 20:
            pixType = .twenty
        case 24:
            pixType = .twentyfour
        case 28:
            pixType = .twentyeight
        case 32:
            pixType = .thirtytwo
        default:
            pixType = .empty
        }
        
        imageView.image = pixType.qrCode
        pixLabel.text = pixType.label
    }
    
    func addUI() {
        self.addSubview(backContainer)
        self.addSubview(container)
        container.addSubview(HStack)
        container.addSubview(VStack)
        HStack.addSubview(roundButton)
        HStack.addSubview(backButton)
        container.addSubview(pixLabelBack)
        pixLabelBack.addSubview(pixLabel)
        
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
            
            HStack.topAnchor.constraint(equalTo: container.topAnchor),
            
            VStack.topAnchor.constraint(equalTo: container.topAnchor),
            VStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            VStack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            VStack.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            roundButton.topAnchor.constraint(equalTo: container.topAnchor),
            roundButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 270),
            
            backButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: container.topAnchor),
            
            imageView.heightAnchor.constraint(equalTo: VStack.heightAnchor, constant: -440),
            imageView.widthAnchor.constraint(equalTo: VStack.widthAnchor, constant: -80),
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: VStack.topAnchor, constant: 80),
            
            priceLabel.topAnchor.constraint(equalTo: VStack.topAnchor, constant: 260),
            priceLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            pixLabelBack.topAnchor.constraint(equalTo: VStack.topAnchor, constant: 450),
            pixLabelBack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            pixLabelBack.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
            pixLabelBack.heightAnchor.constraint(equalTo: VStack.heightAnchor, multiplier: 0.07),
            
            pixLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            pixLabel.centerYAnchor.constraint(equalTo: pixLabelBack.centerYAnchor),
            pixLabel.widthAnchor.constraint(equalTo: pixLabelBack.widthAnchor, multiplier: 0.9),
            
            copyButton.topAnchor.constraint(equalTo: pixLabelBack.bottomAnchor, constant: 20),
            copyButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            ConfirmButton.topAnchor.constraint(equalTo: copyButton.bottomAnchor, constant: 30),
            ConfirmButton.centerXAnchor.constraint(equalTo: VStack.centerXAnchor, constant: -2.5)
            
        ])
    }
}


#Preview {
    PixPopUp()
}

