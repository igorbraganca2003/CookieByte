//
//  File.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 27/05/24.
//

import UIKit

class PixPopUp: UIView {
    
    private lazy var VStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [imageView, priceLabel, pixLabel, buttonStack])
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
    
    private let roundButton: UIView = {
        let round = RoundButton()
        round.setButtonType(type: .close)
        round.translatesAutoresizingMaskIntoConstraints = false
        round.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        return round
    }()
    
    private let backButton: UIView = {
        let round = RoundButton()
        round.setButtonType(type: .back)
        round.translatesAutoresizingMaskIntoConstraints = false
        round.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        return round
    }()
    
    private let imageView: UIImageView = {
        let pix = UIImageView()
        pix.image = UIImage(named: "pix")
        pix.translatesAutoresizingMaskIntoConstraints = false
        return pix
    }()
    
    private let priceLabel: UILabel = {
        let price = UILabel()
        price.textColor = .black
        price.textAlignment = .center
        price.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        price.textColor = UIColor(named: "GreenCookie")
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    private let pixLabel: UILabel = {
        let key = UILabel()
        key.text = "(11) 98936-4585"
        key.textAlignment = .center
        key.textColor = .black
        key.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        key.translatesAutoresizingMaskIntoConstraints = false
        return key
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
    
    // Body
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.backgroundColor = .gray.withAlphaComponent(0.7)
        self.frame = UIScreen.main.bounds
        
        addUI()
        animateIn()
        
        ConfirmButton.addTarget(self, action: #selector(payConfirmed), for: .touchUpInside)
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
        }) { _ in
            self.updateTotalPrice()
        }
    }
    
    @objc func payConfirmed() {
        let popup = DonePopUp()
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(popup)
            popup.animateIn()
        }

        Order.shared.removeCompletedOrders()
        
        self.removeFromSuperview()
    }
    
    func updateTotalPrice() {
        let totalPrice = Order.shared.orders.reduce(0) { $0 + ($1.price * Float($1.qnt)) }
        if totalPrice > 0 {
            priceLabel.text = String(format: "Total: R$ %.2f", totalPrice)
        } else {
            priceLabel.text = "R$ 0,00"
        }
    }
    
    // Functions
    func addUI() {
        self.addSubview(container)
        container.addSubview(VStack)
        container.addSubview(roundButton)
        container.addSubview(backButton)
        
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
            
            backButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 40),
            
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 120),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 60),
            imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -60),
            
            priceLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 350),
            
            pixLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 80),
            
            ConfirmButton.topAnchor.constraint(equalTo: pixLabel.topAnchor, constant: 140)
        ])
    }
}

#Preview() {
    PixPopUp()
}
