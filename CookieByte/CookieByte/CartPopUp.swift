//
//  CartPopUp.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 22/05/24.
//

import UIKit

class CartPopUp: UIView {

    private lazy var VStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [topBar, card])
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Carrinho"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        let round = CloseButton()
        round.setButtonType(type: .close)
        round.translatesAutoresizingMaskIntoConstraints = false
        return round
    }()
    
    private lazy var topBar: UIStackView = {
        let bar = UIStackView(arrangedSubviews: [label, roundButton])
        bar.axis = .horizontal
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private let card: UIView = {
        let card = CartCard()
        return card
    }()
    
    // Body
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.backgroundColor = .gray.withAlphaComponent(0.7)
        self.frame = UIScreen.main.bounds
        
        roundButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
        
        addUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        print("Round button tapped") // Debug print
        animateOut()
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

    // Functions
    func addUI() {
        self.addSubview(container)
        container.addSubview(VStack)
        container.addSubview(topBar)
        
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            container.heightAnchor.constraint(equalToConstant: 700),
            
            VStack.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            VStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            VStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            VStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            
            topBar.topAnchor.constraint(equalTo: container.topAnchor),
            topBar.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.12),
            topBar.widthAnchor.constraint(equalTo: container.widthAnchor),
            
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            
            roundButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 270),
        ])
    }
}

#Preview(){
    return CartPopUp()
}
