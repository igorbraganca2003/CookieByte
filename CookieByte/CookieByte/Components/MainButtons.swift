//
//  MainButtons.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 20/05/24.
//

import UIKit

class MainButtons: UIView {
    
    enum ButtonType {
        case buy
        case confirmPay
        case addCart
        case applePay
        
        var label: String {
            switch self {
            case .buy:
                return "Comprar"
            case .confirmPay:
                return "Confirmar o pagamento"
            case .addCart:
                return "Adicionar ao carrinho"
            case .applePay:
                return  "Pay"
            }
        }
        
        var backColor: UIColor {
            switch self {
            case .buy:
                return UIColor(named: "AccentColor") ?? .orange
            case .confirmPay:
                return UIColor(named: "GreenCookie") ?? .green
            case .addCart, .applePay:
                return UIColor(.white)
            }
        }
        
        var labelColor: UIColor {
            switch self {
            case .buy, .confirmPay:
                return UIColor(.white)
            case .addCart:
                return UIColor(named: "AccentColor") ?? .orange
            case .applePay:
                return UIColor(.black)
            }
        }
    }
    
    private let button: UIButton = {
        
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 8, height: 8)
        button.layer.shadowRadius = 0
        button.layer.shadowOpacity = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.widthAnchor.constraint(equalToConstant: 292)
        ])
    }
    
    func setButton(type: ButtonType) {
        button.setTitle(type.label, for: .normal)
        button.backgroundColor = type.backColor
        button.setTitleColor(type.labelColor, for: .normal)
    }
    
}


#Preview(){
    return MainButtons()
}
