//
//  CookiePopUp.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 20/05/24.
//

import UIKit

class CartPopUp: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    lazy var cartCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.register(CartCardCollection.self, forCellWithReuseIdentifier: "CartCardCell")
        return collectionView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Carrinho"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let payButton: MainButtons = {
        let mainButton = MainButtons()
        mainButton.setButton(type: .pay)
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        return mainButton
    }()
    
    private let keepBuying: MainButtons = {
        let cartButton = MainButtons()
        cartButton.setButton(type: .buyMore)
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        return cartButton
    }()
    
    private lazy var buttonStack: UIStackView = {
        let buttonStack = UIStackView(arrangedSubviews: [keepBuying, payButton])
        buttonStack.axis = .vertical
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        return buttonStack
    }()
    
    private let emptyState: UILabel = {
        let empty = UILabel()
        empty.text = "Carrinho vazio"
        empty.textColor = .black
        empty.textAlignment = .center
        empty.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        empty.translatesAutoresizingMaskIntoConstraints = false
        return empty
    }()
    
    
    //Body
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = UIScreen.main.bounds
        
        addUI()
        
        roundButton.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        keepBuying.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
        
        CookieController.animateIn(view: self, container: container)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func animateOut() {
        CookieController.animateOut(view: self, container: container)
    }
    
    @objc func payButtonTapped() {
        CookieController.payButtonTapped()
    }
    
    // UICollectionViewDataSource
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Order.shared.orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCardCell", for: indexPath) as! CartCardCollection
        cell.cartCard.config(with: Order.shared.orders[indexPath.item])
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 120)
    }
    
    
    func addUI() {
        self.addSubview(backContainer)
        self.addSubview(container)
        container.addSubview(VStack)
        container.addSubview(titleLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateOut))
        backContainer.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            backContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backContainer.widthAnchor.constraint(equalTo: self.widthAnchor),
            backContainer.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            container.centerYAnchor.constraint(equalTo: backContainer.centerYAnchor),
            container.centerXAnchor.constraint(equalTo: backContainer.centerXAnchor),
            container.widthAnchor.constraint(equalTo: backContainer.widthAnchor, multiplier: 0.85),
            container.heightAnchor.constraint(equalToConstant: 700),
            
            VStack.topAnchor.constraint(equalTo: container.topAnchor),
            VStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            VStack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            VStack.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            roundButton.topAnchor.constraint(equalTo: container.topAnchor, constant: -620),
            roundButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 275),
            
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
        ])
        
        if Order.shared.orders.count >= 1 {
            container.addSubview(cartCollectionView)
            container.addSubview(buttonStack)
            
            NSLayoutConstraint.activate([
                cartCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                cartCollectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
                cartCollectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
                cartCollectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -190),
                
                buttonStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 510),
                buttonStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
                buttonStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -28),
                buttonStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -30),
                
                buttonStack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                
                keepBuying.topAnchor.constraint(equalTo: buttonStack.topAnchor),
                keepBuying.centerYAnchor.constraint(equalTo: keepBuying.centerYAnchor),
                
                payButton.topAnchor.constraint(equalTo: buttonStack.topAnchor, constant: 100),
                payButton.centerYAnchor.constraint(equalTo: payButton.centerYAnchor)
            ])
        } else {
            container.addSubview(emptyState)
            
            NSLayoutConstraint.activate([
                emptyState.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                emptyState.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            ])
        }
        
    }
}

#Preview(){
    return CartPopUp()
}
