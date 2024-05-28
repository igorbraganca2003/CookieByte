//
//  CloseButton.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 22/05/24.
//

import UIKit

class RoundButton: UIView {
    
    enum buttonType {
        case close
        case back
        
        var buttonImage: UIImage{
            switch self {
            case .close:
                return UIImage(named: "XButton") ?? UIImage(systemName: "x.circle")!
            case .back:
                return UIImage(named: "BackButton") ?? UIImage(systemName: "chevron.backward.circle")!
            }
        }
    }
    
    private let roundButton: UIButton = {
        let round = UIButton()
        round.translatesAutoresizingMaskIntoConstraints = false
        round.imageView?.contentMode = .scaleAspectFit
        
        return round
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.addSubview(roundButton)
        
        NSLayoutConstraint.activate([
            roundButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            roundButton.widthAnchor.constraint(equalToConstant: 40),
            roundButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setButtonType(type: buttonType){
        roundButton.setImage(type.buttonImage, for: .normal)
    }

    func addTarget(_ target: Any?, action: Selector, for event: UIControl.Event) {
        roundButton.addTarget(target, action: action, for: event)
    }
}


#Preview(){
    RoundButton()
}
