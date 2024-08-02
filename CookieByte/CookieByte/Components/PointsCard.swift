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
        var points = PointsController()
        let label = UILabel()
        label.text = "\(points.userPts) pontos"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusButton: UIButton = {
        let plus = UIButton()
        let title = "Ver Mais +"
        
        let attributedTitle = NSAttributedString(string: title, attributes: [
            .font: UIFont.systemFont(ofSize: 16, weight: .black),
            .foregroundColor: UIColor(named: "AccentColor") ?? .accent,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        plus.setAttributedTitle(attributedTitle, for: .normal)
        plus.translatesAutoresizingMaskIntoConstraints = false
        return plus
    }()
    
    private lazy var CircleStack: UIStackView = {
        let circleStack = UIStackView(arrangedSubviews: createCircles())
        circleStack.axis = .horizontal
        circleStack.spacing = 25
        circleStack.distribution = .fillEqually
        circleStack.translatesAutoresizingMaskIntoConstraints = false
        return circleStack
    }()
    
    
    private func createCircles() -> [UIView] {
        var circlesWithLabels = [UIView]()
        
        let points = PointsController()
        
        let numbers = points.numbers
        let status = points.status
        
        for (index, number) in numbers.enumerated() {
            let circle = UIView()
            
            if status {
                circle.backgroundColor = .greenCookie
            } else {
                circle.backgroundColor = .yellowCookie
            }
            
            circle.layer.cornerRadius = 16.5
            circle.layer.borderWidth = 5
            circle.heightAnchor.constraint(equalToConstant: 33).isActive = true
            circle.widthAnchor.constraint(equalToConstant: 33).isActive = true
            
            
            let imageView = UIImageView()
            
            if status {
                imageView.image = UIImage(named: "check")
            } else {
                imageView.image = UIImage(named: "lock")
            }
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            circle.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 13)
            ])
            
            let label = UILabel()
            label.text = "\(number) pts"
            label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            
            let verticalStack = UIStackView(arrangedSubviews: [circle, label])
            verticalStack.axis = .vertical
            verticalStack.alignment = .center
            verticalStack.spacing = 10
            verticalStack.translatesAutoresizingMaskIntoConstraints = false
            
            circlesWithLabels.append(verticalStack)
        }
        
        return circlesWithLabels
    }
    
    private let backBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .greenCookie
        bar.layer.borderWidth = 3
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        
        plusButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButton() {
        let popup = PointsPopUp()
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(popup)
            CookieController.animateIn(view: popup, container: popup)
        }
    }
    
    func setUI() {
        self.addSubview(rectangle)
        rectangle.addSubview(stack)
        stack.addSubview(backBar)
        stack.addSubview(CircleStack)
        
        NSLayoutConstraint.activate([
            rectangle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rectangle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rectangle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            rectangle.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 3),
            
            stack.widthAnchor.constraint(equalTo: rectangle.widthAnchor, multiplier: 0.9),
            stack.heightAnchor.constraint(equalTo: rectangle.heightAnchor, multiplier: 0.7),
            stack.centerXAnchor.constraint(equalTo: rectangle.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: rectangle.centerYAnchor),
            
            topStack.heightAnchor.constraint(equalToConstant: 30),
            topStack.widthAnchor.constraint(equalTo: stack.widthAnchor),
            topStack.bottomAnchor.constraint(equalTo: CircleStack.topAnchor, constant: -20),
            
            CircleStack.widthAnchor.constraint(equalTo: stack.widthAnchor),
            CircleStack.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            
            backBar.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            backBar.centerYAnchor.constraint(equalTo: CircleStack.centerYAnchor, constant: -12),
            backBar.widthAnchor.constraint(equalTo: stack.widthAnchor, constant: -20),
            backBar.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.08),
        ])
    }
}

#Preview {
    return PointsCard()
}
