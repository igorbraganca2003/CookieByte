//
//  CloseButton.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 22/05/24.
//

import UIKit

class CloseButton: UIView {
    
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
//        let xbutton = UIImage(named: "XButton")
        
//        close.setImage(xbutton, for: .normal)
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
//            roundButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            roundButton.widthAnchor.constraint(equalToConstant: 40),
            roundButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setButtonType(type: buttonType){
        roundButton.setImage(type.buttonImage, for: .normal)
    }

}


#Preview(){
    CloseButton()
}
