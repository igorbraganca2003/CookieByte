//
//  PointsCard.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 12/07/24.
//

import UIKit

class PointsCard: UIView {

    private let rectangle: UIView = {
        let rectangle = UIView()
        rectangle.layer.borderWidth = 6
        rectangle.backgroundColor = UIColor.white
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
        
        let points = PointsController.shared
        let userPoints = points.userPts
        let numbers = points.numbers
        
        for number in numbers {
            let circle = UIView()
            
            // Define a cor do círculo
            circle.backgroundColor = userPoints >= number ? .greenCookie : .yellowCookie
            
            circle.layer.cornerRadius = 16.5
            circle.layer.borderWidth = 5
            circle.heightAnchor.constraint(equalToConstant: 33).isActive = true
            circle.widthAnchor.constraint(equalToConstant: 33).isActive = true
            
            let imageView = UIImageView()
            // Define o ícone de acordo com os pontos do usuário
            imageView.image = userPoints >= number ? UIImage(named: "check") : UIImage(named: "lock")
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
    
    private func updateCircles() {
        // Remove todas as views atuais do CircleStack
        CircleStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Adiciona as novas views de círculo
        let circles = createCircles()
        circles.forEach { CircleStack.addArrangedSubview($0) }
    }


    private let backBar: UIView = {
        let bar = UIView()
        bar.layer.borderWidth = 3
        bar.layer.borderColor = UIColor.black.cgColor // Temporário para visibilidade
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()

    private let gradientLayer = CAGradientLayer()

    private func setupBackBar() {
        backBar.layer.addSublayer(gradientLayer)
        gradientLayer.frame = backBar.bounds
        gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.lightGray.cgColor, UIColor.lightGray.cgColor, UIColor.lightGray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.locations = [0, 0.25, 0.5, 0.75, 1] // Posiciona os gradientes
    }

    private func updateBackBar() {
        let points = PointsController.shared.userPts
        let thresholds = PointsController.shared.numbers
        let numParts = 4 // Número de partes na barra
        let thresholdCount = min(thresholds.count, numParts)

        var colors: [CGColor] = []

        for i in 0..<numParts {
            if i < thresholdCount {
                if points >= thresholds[i] {
                    colors.append(UIColor.greenCookie.cgColor)
                } else if i == thresholdCount - 1 || points < thresholds[i] {
                    colors.append(UIColor.yellowCookie.cgColor)
                } else {
                    colors.append(UIColor.lightGray.cgColor)
                }
            } else {
                colors.append(UIColor.lightGray.cgColor)
            }
        }

        // Atualiza as partes restantes para cinza
        while colors.count < numParts {
            colors.append(UIColor.lightGray.cgColor)
        }

        gradientLayer.colors = colors
        gradientLayer.frame = backBar.bounds // Atualiza o frame do gradient layer
        gradientLayer.setNeedsDisplay() // Solicita uma atualização do gradient layer
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        updatePointsLabel()
        setupBackBar() // Configura o Gradient Layer ao inicializar
        updateBackBar() // Atualiza a barra ao inicializar
        plusButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(pointsDidChange), name: .pointsDidChange, object: nil)
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
    
    @objc func pointsDidChange() {
        updatePointsLabel()
        updateCircles() // Atualiza os círculos quando os pontos mudam
        updateBackBar() // Atualiza a barra quando os pontos mudam
        layoutIfNeeded() // Força a atualização do layout
    }
    
    func updatePointsLabel() {
        let points = PointsController.shared.userPts
        pointsLabel.text = "\(points) pontos"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
