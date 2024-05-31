//
//  CookiePopUp.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 20/05/24.
//

import UIKit

class PopUpModel: UIView {

    private lazy var VStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [roundButton])
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = UIScreen.main.bounds
        
        addUI()
        
        roundButton.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
        
        CookieController.animateIn(view: self, container: container)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func animateOut() {
        CookieController.animateOut(view: self, container: container)
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
            backContainer.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            container.centerYAnchor.constraint(equalTo: backContainer.centerYAnchor),
            container.centerXAnchor.constraint(equalTo: backContainer.centerXAnchor),
            container.widthAnchor.constraint(equalTo: backContainer.widthAnchor, multiplier: 0.85),
            container.heightAnchor.constraint(equalToConstant: 700),
            
            VStack.topAnchor.constraint(equalTo: container.topAnchor),
            VStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            VStack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            VStack.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            roundButton.topAnchor.constraint(equalTo: container.topAnchor, constant: -620),
            roundButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 275)
        ])
    }
}

#Preview {
    PopUpModel()
}

