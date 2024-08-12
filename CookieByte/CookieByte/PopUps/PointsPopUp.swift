//
//  PointsPopUp.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 01/08/24.
//

import Foundation
import UIKit

class PointsPopUp: UIView {

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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recompensas"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var CircleStack: UIStackView = {
        let circleStack = UIStackView(arrangedSubviews: createCircles())
        circleStack.axis = .vertical
        circleStack.spacing = 50
        circleStack.distribution = .fillEqually
        circleStack.translatesAutoresizingMaskIntoConstraints = false
        return circleStack
    }()
    
    private func createCircles() -> [UIView] {
        var circlesWithLabels = [UIView]()
        
        let points = PointsController.shared
        let userPoints = points.userPts
        let numbers = points.numbers
        let pointsDesc = points.pointsDesc
        
        for (index, number) in numbers.enumerated() {
            let circle = UIView()
            let isUnlocked = userPoints >= number
            
            circle.backgroundColor = isUnlocked ? .greenCookie : .yellowCookie
            circle.layer.cornerRadius = 25
            circle.layer.borderWidth = 5
            circle.heightAnchor.constraint(equalToConstant: 50).isActive = true
            circle.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            let imageView = UIImageView()
            imageView.image = isUnlocked ? UIImage(named: "check") : UIImage(named: "lock")
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            circle.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 18)
            ])
            
            let label = UILabel()
            label.text = "\(number) pts"
            label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
            label.textColor = isUnlocked ? .greenCookie : .yellowCookie
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            
            let description = UILabel()
            description.text = pointsDesc[index]
            description.textColor = UIColor.black
            description.lineBreakMode = .byWordWrapping
            description.numberOfLines = 3
            description.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            description.translatesAutoresizingMaskIntoConstraints = false
            
            let labelStack = UIStackView(arrangedSubviews: [label, description])
            labelStack.axis = .vertical
            labelStack.alignment = .leading
            labelStack.spacing = 0
            labelStack.translatesAutoresizingMaskIntoConstraints = false
            
            let verticalStack = UIStackView(arrangedSubviews: [circle, labelStack])
            verticalStack.axis = .horizontal
            verticalStack.alignment = .leading
            verticalStack.spacing = 30
            verticalStack.translatesAutoresizingMaskIntoConstraints = false
            
            circlesWithLabels.append(verticalStack)
            
            NSLayoutConstraint.activate([
                labelStack.widthAnchor.constraint(equalTo: circle.widthAnchor, multiplier: 3.9)
            ])
        }
        
        return circlesWithLabels
    }
    
    private func updateCircles() {
        // Remove todas as views atuais do CircleStack
        CircleStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Adiciona as novas views de círculo
        let circles = createCircles()
        circles.forEach { CircleStack.addArrangedSubview($0) }
    }

    private let backBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .black
        bar.layer.borderWidth = 3
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = UIScreen.main.bounds
        
        addUI()
        
        roundButton.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
        
        CookieController.animateIn(view: self, container: container)
        
        // Atualize os círculos quando a view for carregada
        updateCircles()
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
        container.addSubview(titleLabel)
        container.addSubview(backBar)
        container.addSubview(CircleStack)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateOut))
        backContainer.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            backContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backContainer.widthAnchor.constraint(equalTo: self.widthAnchor),
            backContainer.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 100),
            
            container.centerYAnchor.constraint(equalTo: backContainer.centerYAnchor),
            container.centerXAnchor.constraint(equalTo: backContainer.centerXAnchor),
            container.widthAnchor.constraint(equalTo: backContainer.widthAnchor, multiplier: 0.85),
            container.heightAnchor.constraint(equalToConstant: 700),
            
            VStack.topAnchor.constraint(equalTo: container.topAnchor),
            VStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            VStack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            VStack.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            roundButton.topAnchor.constraint(equalTo: container.topAnchor, constant: -620),
            roundButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 270),
            
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            
            CircleStack.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 80),
            CircleStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            
            backBar.centerXAnchor.constraint(equalTo: CircleStack.centerXAnchor, constant: -112.5),
            backBar.centerYAnchor.constraint(equalTo: CircleStack.centerYAnchor, constant: -10),
            backBar.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.02),
            backBar.heightAnchor.constraint(equalTo: CircleStack.heightAnchor, multiplier: 0.9),
        ])
    }
}

#Preview {
    PointsPopUp()
}
