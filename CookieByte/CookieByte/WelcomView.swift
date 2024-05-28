//
//  WelcomView.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 28/05/24.
//

import UIKit

class WelcomeView: UIView {
    
    private let container: UIView = {
        let container = UIView()
        container.backgroundColor = .blueCookie
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.borderWidth = 6
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

//    private lazy var welcomeView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [appName, srChocolato, welcome])
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//        stack.alignment = .fill // Mudança para garantir que os subviews preencham a largura da stack
//        stack.distribution = .fillEqually // Mudança para garantir que os subviews tenham tamanhos proporcionais
//        stack.spacing = 10
//        stack.backgroundColor = .blue // Use a cor padrão .blue se .blueCookie não estiver definida
//        return stack
//    }()
    
    private let appName: UILabel = {
        let label = UILabel()
        label.text = "CookieByte"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let srChocolato: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let welcome: UILabel = {
        let welcome = UILabel()
        welcome.text = "Bem Vindo"
        welcome.textAlignment = .center
        return welcome
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUI(){
        self.addSubview(container)
        container.addSubview(appName)
        
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 5),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 12),
            
            appName.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            appName.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 100)
            
        ])
    }

}

#Preview(){
    return WelcomeView()
}
