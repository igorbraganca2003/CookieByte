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
        case pix
        case buyMore
        case pay
        case rescuePoints
        
        var label: String {
            switch self {
            case .buy:
                return "Comprar"
            case .confirmPay:
                return "Confirmar Pagamento"
            case .addCart:
                return "Adicionar ao carrinho"
            case .pix:
                return  "Pagar Com Pix"
            case .buyMore:
                return "Continar Comprando"
            case .pay:
                return "Pagar"
            case .rescuePoints:
                return "Pegar Recompensas"
            }
        }
        
        var backColor: UIColor {
            switch self {
            case .buy, .pay:
                return UIColor(named: "AccentColor") ?? .orange
            case .confirmPay, .pix:
                return UIColor(named: "GreenCookie") ?? .green
            case .addCart, .buyMore, .rescuePoints:
                return UIColor(.white)
            }
        }
        
        var labelColor: UIColor {
            switch self {
            case .buy, .confirmPay, .pay, .pix:
                return UIColor(.white)
            case .addCart, .buyMore:
                return UIColor(named: "AccentColor") ?? .orange
            case .rescuePoints:
                return UIColor.black
            }
        }
    }
    
    let button: UIButton = {
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
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.widthAnchor.constraint(equalToConstant: 285)
        ])
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setButton(type: ButtonType) {
        button.setTitle(type.label, for: .normal)
        button.backgroundColor = type.backColor
        button.setTitleColor(type.labelColor, for: .normal)
    }
    
    @objc private func buttonTapped() {
        animateButton()
    }
    
    private func animateButton() {
        UIView.animate(withDuration: 0.1, animations: {
            self.button.transform = CGAffineTransform(translationX: 8, y: 8)
            self.button.layer.shadowOffset = CGSize(width: 0, height: 0)
        }) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.button.transform = .identity
                self.button.layer.shadowOffset = CGSize(width: 8, height: 8)
            })
        }
    }
    
    // Método público para adicionar o target ao botão interno
    func addTarget(_ target: Any?, action: Selector, for event: UIControl.Event) {
        button.addTarget(target, action: action, for: event)
    }
}


#Preview(){
    return MainButtons()
}
