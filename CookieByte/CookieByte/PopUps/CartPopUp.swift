//
//  CookiePopUp.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 20/05/24.
//
import UIKit
import PassKit

class CartPopUp: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private lazy var VStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [roundButton])
        vStack.axis = .vertical
        vStack.isUserInteractionEnabled = true
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
        container.isUserInteractionEnabled = true
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
    
    private lazy var priceStack: UIStackView = {
        let priceStack = UIStackView(arrangedSubviews: [totalLabel, priceLabel])
        priceStack.axis = .horizontal
        priceStack.spacing = 100
        priceStack.translatesAutoresizingMaskIntoConstraints = false
        return priceStack
    }()
    
    private let totalLabel: UILabel = {
        let total = UILabel()
        total.text = "Valor Total"
        total.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        total.translatesAutoresizingMaskIntoConstraints = false
        return total
    }()
    
    private let priceLabel: UILabel = {
        let price = UILabel()
        price.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    private let payButton: MainButtons = {
        let mainButton = MainButtons()
        mainButton.setButton(type: .pix)
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        return mainButton
    }()
    
    private let applePayButton: PKPaymentButton = {
        let payButton = PKPaymentButton(paymentButtonType: .plain, paymentButtonStyle: .white)
        payButton.addTarget(self, action: #selector(applePayButtonTapped), for: .touchUpInside)
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        payButton.layer.borderWidth = 5
        payButton.layer.borderColor = UIColor.black.cgColor
        payButton.layer.shadowOffset = CGSize(width: 8, height: 8)
        payButton.layer.shadowRadius = 0
        payButton.layer.shadowOpacity = 10
        payButton.layer.shadowColor = UIColor.black.cgColor
        
        return payButton
    }()
    
    
    private lazy var buttonStack: UIStackView = {
        let buttonStack = UIStackView(arrangedSubviews: [payButton, applePayButton])
        buttonStack.axis = .vertical
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        return buttonStack
    }()
    
    private let emptyState: UILabel = {
        let empty = UILabel()
        empty.text = "Carrinho vazio"
        empty.textColor = .black
        empty.textAlignment = .center
        empty.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        empty.translatesAutoresizingMaskIntoConstraints = false
        return empty
    }()
    
    private let maneiro: UIImageView = {
        let maneiro = UIImageView()
        maneiro.image = UIImage(named: "ManeiroEmpty")
        maneiro.translatesAutoresizingMaskIntoConstraints = false
        return maneiro
    }()
    
    private let payController = PayController()
    
    // Body
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = UIScreen.main.bounds
        
        addUI()
        
        roundButton.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        applePayButton.addTarget(self, action: #selector(applePayButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(orderUpdated), name: NSNotification.Name("OrderUpdated"), object: nil)
        
        CookieController.animateIn(view: self, container: container)
        
        // Atualizar preço total na inicialização
        updateTotalPrice()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func animateOut() {
        CookieController.animateOut(view: self, container: container)
    }
    
    @objc func payButtonTapped() {
        if LocationController.locationShared.inOrOut {
            CookieController.payButtonTapped(from: CookiePopUp().self)
            print("Dentro da localização ")
        } else {
            let alert = UIAlertController(title: "Fora da Localização", message: "Para concluir sua compra é necessário estar dentro da área da Universidade Presbiteriana Mackenzie", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Entendido", style: UIAlertAction.Style.default, handler: nil))
            
            if let viewController = self.window?.rootViewController {
                viewController.present(alert, animated: true, completion: nil)
            }
            print("fora da localização")
        }
    }

    @objc func applePayButtonTapped() {
        if LocationController.locationShared.inOrOut {
            let items = Order.shared.orders.map { order in
                return PKPaymentSummaryItem(label: order.cookie, amount: NSDecimalNumber(decimal: Decimal(order.price * Double(order.qnt))))
            }
            let totalAmount = Order.shared.orders.reduce(0) { $0 + $1.price * Double($1.qnt) }
            let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(decimal: Decimal(totalAmount)))
            
            payController.startPayment(items: items + [total]) { success, data in
                if success {
                    print("Apple Pay Payment Successful: \(data ?? [:])")
                } else {
                    print("Apple Pay Payment Failed")
                }
            }
        } else {
            let alert = UIAlertController(title: "Fora da Localização", message: "Para concluir sua compra é necessário estar próximo da área da Universidade Presbiteriana Mackenzie", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Entendido", style: UIAlertAction.Style.default, handler: nil))
            
            if let viewController = self.window?.rootViewController {
                viewController.present(alert, animated: true, completion: nil)
            }
            print("fora da localização")
        }
    }
    
    
    @objc func orderUpdated() {
        cartCollectionView.reloadData()
        updateTotalPrice()
        updateCartUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("OrderUpdated"), object: nil)
    }
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Order.shared.orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCardCell", for: indexPath) as! CartCardCollection
        cell.cartCard.config(with: Order.shared.orders[indexPath.item], at: indexPath.item)
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 120)
    }
    
    private func updateTotalPrice() {
        print("Updating total price...")
        CookieController.updateTotalPrice(label: priceLabel)
    }
    
    func addUI() {
        self.addSubview(backContainer)
        self.addSubview(container)
        container.addSubview(VStack)
        //        container.addSubview(roundButton)
        
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
            roundButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 270)
        ])
        
        updateCartUI()
    }
    
    private func updateCartUI() {
        // Remover todas as subviews antes de adicionar novas, exceto o roundButton
        container.subviews.forEach { subview in
            if subview != roundButton && subview != VStack {
                subview.removeFromSuperview()
            }
        }
        container.addSubview(VStack)
        
        if Order.shared.orders.isEmpty {
            container.addSubview(emptyState)
            container.addSubview(maneiro)
            
            NSLayoutConstraint.activate([
                emptyState.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                emptyState.topAnchor.constraint(equalTo: container.topAnchor, constant: 120),
                
                maneiro.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                maneiro.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.64),
                maneiro.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
                maneiro.topAnchor.constraint(equalTo: emptyState.topAnchor, constant: 125),
            ])
        } else {
            container.addSubview(cartCollectionView)
            container.addSubview(buttonStack)
            container.addSubview(priceStack)
            container.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
                
                cartCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                cartCollectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
                cartCollectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
                cartCollectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -230),
                
                priceStack.topAnchor.constraint(equalTo: cartCollectionView.bottomAnchor, constant: 20),
                priceStack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                
                buttonStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 510),
                buttonStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
                buttonStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -28),
                buttonStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -30),
                
                buttonStack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                
                payButton.topAnchor.constraint(equalTo: buttonStack.topAnchor, constant: 20),
                payButton.centerYAnchor.constraint(equalTo: buttonStack.centerYAnchor),
                payButton.heightAnchor.constraint(equalTo: buttonStack.heightAnchor, multiplier: 0.37),
                payButton.widthAnchor.constraint(equalTo: buttonStack.widthAnchor),
                
                applePayButton.topAnchor.constraint(equalTo: buttonStack.topAnchor, constant: 100),
                applePayButton.centerYAnchor.constraint(equalTo: applePayButton.centerYAnchor)
            ])
        }
    }
}

#Preview(){
    return CartPopUp()
}
