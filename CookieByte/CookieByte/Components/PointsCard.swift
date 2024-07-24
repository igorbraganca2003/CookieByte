//
//  PointsCard.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 12/07/24.
//

import Foundation
import UIKit

class PointsCard: UIView {
    
    private let rectangle: UIView = {
        let rectangle = UIView()
        rectangle.layer.borderWidth = 6
        rectangle.backgroundColor = UIColor(.white)
        rectangle.layer.shadowOffset = CGSize(width: 9, height: 9)
        rectangle.layer.shadowRadius = 0
        rectangle.layer.shadowOpacity = 10
        rectangle.layer.shadowColor = UIColor.black.cgColor
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        return rectangle
    }()
    
    private lazy var topStack: UIStackView = {
        let top = UIStackView(arrangedSubviews: [pointsLabel, plusButton])
        top.spacing = 80
//        top.layer.borderWidth = 1
        top.translatesAutoresizingMaskIntoConstraints = false
        return top
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.text = "50 pontos"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusButton: UIButton = {
        let copy = UIButton()
        let title = "Ver Mais +"
        
        let attributedTitle = NSAttributedString(string: title, attributes: [
            .font: UIFont.systemFont(ofSize: 16, weight: .black),
            .foregroundColor: UIColor(named: "Accent") ?? .orange,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        copy.setAttributedTitle(attributedTitle, for: .normal)
        copy.translatesAutoresizingMaskIntoConstraints = false
        return copy
    }()
    
    
    //Body
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.addSubview(rectangle)
        rectangle.addSubview(topStack)
        
        NSLayoutConstraint.activate([
            rectangle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rectangle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rectangle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            rectangle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.17),
            
            topStack.widthAnchor.constraint(equalTo: rectangle.widthAnchor, multiplier: 0.9),
            topStack.centerXAnchor.constraint(equalTo: rectangle.centerXAnchor),
            topStack.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 15)
        ])
    }
    
}

#Preview {
    return PointsCard()
}
