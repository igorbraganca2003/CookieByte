//
//  CartPopUp.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 26/05/24.
//

import UIKit

class CartPopUp: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private lazy var cartCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CartCardCollection.self, forCellWithReuseIdentifier: "CartCardCell")
        return collectionView
    }()
    
    private let container: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.borderWidth = 6
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let closeButton: UIView = {
        let close = RoundButton()
        close.setButtonType(type: .close)
        close.translatesAutoresizingMaskIntoConstraints = false
        close.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        return close
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Carrinho"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Body
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.backgroundColor = .gray.withAlphaComponent(0.7)
        self.frame = UIScreen.main.bounds
        
        addUI()
        animateIn()
        loadCartItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc func animateIn(){
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    // Carrega os itens do carrinho
    func loadCartItems() {
        self.cartCollectionView.reloadData()
    }
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    // Adiciona os elementos visuais
    func addUI() {
        self.addSubview(container)
        container.addSubview(closeButton)
        container.addSubview(titleLabel)
        container.addSubview(cartCollectionView)
        
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            
            closeButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 40),
            closeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -60),
            
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            
            cartCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            cartCollectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            cartCollectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            cartCollectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20)
        ])
    }
}


#Preview {
    return CartPopUp()
}

