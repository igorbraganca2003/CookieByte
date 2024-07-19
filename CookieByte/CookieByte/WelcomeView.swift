//
//  WelcomeView.swift
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
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let appName: UILabel = {
        let label = UILabel()
        label.text = "CookieByte"
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let srChocolato: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Sr.Chocolato")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let welcome: UILabel = {
        let welcome = UILabel()
        welcome.text = "Bem Vindo!"
        welcome.textColor = .white
        welcome.numberOfLines = 2
        welcome.font = .systemFont(ofSize: 80, weight: .black)
        welcome.textAlignment = .center
        welcome.translatesAutoresizingMaskIntoConstraints = false
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
        container.addSubview(srChocolato)
        container.addSubview(welcome)
        
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            
            appName.topAnchor.constraint(equalTo: container.topAnchor, constant: 80),
            appName.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
            
            srChocolato.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            srChocolato.topAnchor.constraint(equalTo: container.topAnchor, constant: 190),
            srChocolato.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.85),
            srChocolato.heightAnchor.constraint(equalTo: srChocolato.widthAnchor),
            
            welcome.topAnchor.constraint(equalTo: srChocolato.bottomAnchor, constant: 60),
            welcome.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            welcome.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1)
        ])
    }
}

#Preview {
    return WelcomeView()
}
