////
////  novoCarrinho.swift
////  CookieByte
////
////  Created by Igor Bragança Toledo on 27/05/24.
////
//
//import UIKit
//
//class CartPopUp: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    private lazy var VStack: UIStackView = {
//        let vStack = UIStackView(arrangedSubviews: [buttonStack])
//        vStack.axis = .vertical
//        vStack.spacing = 10
//        vStack.translatesAutoresizingMaskIntoConstraints = false
//        return vStack
//    }()
//    
//    private lazy var cartCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .clear
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.dataSource = self
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.delegate = self
//        collectionView.register(CartCardCollection.self, forCellWithReuseIdentifier: "CartCardCell")
//        return collectionView
//    }()
//    
//    private let container: UIView = {
//        let container = UIView()
//        container.backgroundColor = .white
//        container.layer.borderColor = UIColor.black.cgColor
//        container.layer.borderWidth = 6
//        container.translatesAutoresizingMaskIntoConstraints = false
//        return container
//    }()
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Carrinho"
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let roundButton: RoundButton = {
//        let round = RoundButton()
//        round.setButtonType(type: .close)
//        round.translatesAutoresizingMaskIntoConstraints = false
//        round.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
//        return round
//    }()
//    
//    private let payButton: MainButtons = {
//        let mainButton = MainButtons()
//        mainButton.setButton(type: .pay)
//        mainButton.translatesAutoresizingMaskIntoConstraints = false
//        return mainButton
//    }()
//    
//    private let keepBuying: MainButtons = {
//        let cartButton = MainButtons()
//        cartButton.setButton(type: .buyMore)
//        cartButton.translatesAutoresizingMaskIntoConstraints = false
//        return cartButton
//    }()
//    
//    private lazy var buttonStack: UIStackView = {
//        let buttonStack = UIStackView(arrangedSubviews: [keepBuying, payButton])
//        buttonStack.axis = .vertical
//        buttonStack.translatesAutoresizingMaskIntoConstraints = false
//        return buttonStack
//    }()
//    
//    private let emptyState: UILabel = {
//        let empty = UILabel()
//        empty.text = "Carrinho vazio"
//        empty.textColor = .black
//        empty.textAlignment = .center
//        empty.font = UIFont.systemFont(ofSize: 28, weight: .bold)
//        empty.translatesAutoresizingMaskIntoConstraints = false
//        return empty
//    }()
//    
//    
//    
//    // Body
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
//        self.backgroundColor = .gray.withAlphaComponent(0.7)
//        self.frame = UIScreen.main.bounds
//        
//        addUI()
//        animateIn()
//        
//        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
//        keepBuying.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    @objc fileprivate func animateOut() {
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, animations: {
//            self.container.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
//            self.alpha = 0
//        }) { (complete) in
//            if complete {
//                self.removeFromSuperview()
//            }
//        }
//    }
//    
//    @objc func animateIn() {
//        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
//        self.alpha = 0
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, animations: {
//            self.container.transform = .identity
//            self.alpha = 1
//        })
//    }
//    
//    @objc func payButtonTapped(){
//        let popup = PixPopUp()
//        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
//            window.addSubview(popup)
//            popup.animateIn()
//        }
//        print("Botão de compra pressionado")
//        self.removeFromSuperview()
//    }
//    
//    // Carrega os itens do carrinho
//    func loadCartItems() {
//        self.cartCollectionView.reloadData()
//    }
//    
//    // UICollectionViewDataSource
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return Order.shared.orders.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCardCell", for: indexPath) as! CartCardCollection
//        cell.cartCard.config(with: Order.shared.orders[indexPath.item])
//        return cell
//    }
//    
//    // UICollectionViewDelegateFlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width - 40, height: 120)
//    }
//    
//    
//    
//    // Functions
//    func addUI() {
//        self.addSubview(container)
//        container.addSubview(roundButton)
//        container.addSubview(titleLabel)
//        
//        
//        NSLayoutConstraint.activate([
//            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
//            container.heightAnchor.constraint(equalToConstant: 700),
//            
//            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
//            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
//            
//            roundButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -60),
//            roundButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 40),
//        ])
//        
//        if Order.shared.orders.count >= 1 {
//            container.addSubview(VStack)
//            container.addSubview(cartCollectionView)
//            
//            NSLayoutConstraint.activate([
//                cartCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//                cartCollectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
//                cartCollectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
//                cartCollectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -190),
//                
//                VStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
//                VStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
//                VStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
//                VStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
//                
//                buttonStack.topAnchor.constraint(equalTo: container.centerYAnchor, constant: 150),
//                buttonStack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
//                
//                keepBuying.topAnchor.constraint(equalTo: buttonStack.topAnchor, constant: 10),
//                keepBuying.centerYAnchor.constraint(equalTo: keepBuying.centerYAnchor),
//                
//                payButton.topAnchor.constraint(equalTo: buttonStack.topAnchor, constant: 100),
//                payButton.centerYAnchor.constraint(equalTo: payButton.centerYAnchor)
//            ])
//        } else {
//            container.addSubview(emptyState)
//            
//            NSLayoutConstraint.activate([
//                emptyState.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//                emptyState.centerXAnchor.constraint(equalTo: container.centerXAnchor),
//            ])
//        }
//    }
//}
//
//
//#Preview {
//    CartPopUp()
//}
