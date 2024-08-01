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
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topStack, CircleStack])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var topStack: UIStackView = {
        let top = UIStackView(arrangedSubviews: [pointsLabel, plusButton])
        top.axis = .horizontal
        top.spacing = 80
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
    
    private lazy var CircleStack: UIStackView = {
        let circleStack = UIStackView(arrangedSubviews: createCircles())
        circleStack.axis = .horizontal
        circleStack.spacing = 30
        circleStack.distribution = .fillEqually
        circleStack.translatesAutoresizingMaskIntoConstraints = false
        return circleStack
    }()
    
    private func createCircles() -> [UIView] {
        var circles = [UIView]()
        for _ in 0..<5 {
            let circle = UIView()
            circle.backgroundColor = .green
            circle.layer.cornerRadius = 16
            circle.layer.borderWidth = 5
            circle.heightAnchor.constraint(equalToConstant: 33).isActive = true
            circles.append(circle)
        }
        return circles
    }
    
    private let backBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .green
        bar.layer.borderWidth = 3
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    
    //Body
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.addSubview(rectangle)
        rectangle.addSubview(stack)
        stack.addSubview(backBar)
        stack.addSubview(CircleStack)
        
        NSLayoutConstraint.activate([
            
            rectangle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rectangle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rectangle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            rectangle.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 3),
            
            stack.widthAnchor.constraint(equalTo: rectangle.widthAnchor, multiplier: 0.9),
            stack.heightAnchor.constraint(equalTo: rectangle.heightAnchor, multiplier: 0.7),
            stack.centerXAnchor.constraint(equalTo: rectangle.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: rectangle.centerYAnchor),
            
            topStack.heightAnchor.constraint(equalToConstant: 30),
            topStack.widthAnchor.constraint(equalTo: stack.widthAnchor),
            topStack.bottomAnchor.constraint(equalTo: CircleStack.topAnchor, constant: -30),
            
            CircleStack.widthAnchor.constraint(equalTo: stack.widthAnchor),
            
            backBar.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            backBar.centerYAnchor.constraint(equalTo: CircleStack.centerYAnchor),
            backBar.widthAnchor.constraint(equalTo: stack.widthAnchor),
            backBar.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.08),
        ])
    }

    
}

#Preview {
    return PointsCard()
}
