//
//  ViewController.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 14/05/24.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {

    // Icone de carrinho
    private var cookieCollection: CookieCollection?
    var icon: CookiePopUp = CookiePopUp()
    var cart: Int = Order.shared.orders.count
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.showsVerticalScrollIndicator = false
        scroll.alwaysBounceVertical = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pointsLabel: UILabel = {
        let tittleLabel = UILabel()
        tittleLabel.text = "Seus Pontos"
        tittleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        tittleLabel.textColor = .black
        tittleLabel.translatesAutoresizingMaskIntoConstraints = false
        return tittleLabel
    }()
    
    let tittleLabel: UILabel = {
        let tittleLabel = UILabel()
        tittleLabel.text = "Cookies"
        tittleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        tittleLabel.textColor = .black
        tittleLabel.translatesAutoresizingMaskIntoConstraints = false
        return tittleLabel
    }()
    
    let favoriteLabel: UILabel = {
        let favoriteLabel = UILabel()
        favoriteLabel.text = "Favoritos"
        favoriteLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        favoriteLabel.textColor = .black
        favoriteLabel.translatesAutoresizingMaskIntoConstraints = false
        return favoriteLabel
    }()
    
    private let pointsCard: PointsCard = {
        let pointsCard = PointsCard()
        pointsCard.translatesAutoresizingMaskIntoConstraints = false
        return pointsCard
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 48, weight: .black)]
        self.title = "Bem-vindo"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "cart.fill.badge.plus"), style: .plain, target: self, action: #selector(didTapButton)),
            UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(didTapButton))
        ]
        
        if cart >= 1 {
            self.navigationItem.rightBarButtonItems?[1].isHidden = true
        } else {
            self.navigationItem.rightBarButtonItems?[0].isHidden = true
        }
        
        cookieCollection?.viewController = self
        icon.viewController = self
        setUI()
    }
    
    @objc func didTapButton() {
        let popup = CartPopUp()
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(popup)
            CookieController.animateIn(view: popup, container: popup)
        }
    }
    
    func setUI() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.scrollView.delegate = self
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        setElements()
    }
    
    func setElements() {
        
        contentView.addSubview(pointsLabel)
        contentView.addSubview(pointsCard)
        contentView.addSubview(tittleLabel)
        contentView.addSubview(favoriteLabel)
        
        setPointsLabel()
        setPointsCard()
        setTitleLabel()
        setCardsScroll()
        setFavoriteLabel()
        setFavorites()
    }
    
    func setPointsLabel() {
        NSLayoutConstraint.activate([
            pointsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            pointsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            pointsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        ])
    }
    
    func setPointsCard() {
        NSLayoutConstraint.activate([
            pointsCard.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: 20),
            pointsCard.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -3),
            pointsCard.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9)
        ])
    }
    
    func setTitleLabel() {
        NSLayoutConstraint.activate([
            tittleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tittleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            tittleLabel.topAnchor.constraint(equalTo: pointsCard.bottomAnchor, constant: 40)
        ])
    }
    
    func setCardsScroll() {
        let cardsScroll = UIScrollView()
        cardsScroll.showsHorizontalScrollIndicator = false
        cardsScroll.alwaysBounceHorizontal = false
        cardsScroll.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(cardsScroll)
        
        NSLayoutConstraint.activate([
            cardsScroll.topAnchor.constraint(equalTo: tittleLabel.bottomAnchor),
            cardsScroll.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardsScroll.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardsScroll.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        setCards(in: cardsScroll)
    }
    
    func setCards(in scrollView: UIScrollView) {
        let cookieCollection = CookieCollection()
        //print("Aqui está o:\(cookieCollection) !!!!!!!!!!")
        scrollView.addSubview(cookieCollection)
        
        cookieCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cookieCollection.topAnchor.constraint(equalTo: scrollView.topAnchor),
            cookieCollection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            cookieCollection.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            cookieCollection.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            cookieCollection.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            cookieCollection.widthAnchor.constraint(equalToConstant: 1000)
        ])
        
        self.cookieCollection = cookieCollection
    }
    
    func setFavoriteLabel() {
        guard let cookieCollection = self.cookieCollection else { return }
        
        NSLayoutConstraint.activate([
            favoriteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            favoriteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            favoriteLabel.topAnchor.constraint(equalTo: cookieCollection.bottomAnchor, constant: 40)
        ])
    }
    
    func setFavorites() {
        let favoriteCollection = FavoriteCollection()
        contentView.addSubview(favoriteCollection)
        
        favoriteCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoriteCollection.topAnchor.constraint(equalTo: favoriteLabel.bottomAnchor),
            favoriteCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            favoriteCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favoriteCollection.heightAnchor.constraint(equalToConstant: 300),
            favoriteCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            scrollView.contentOffset.x = 0
        }
    }
}

#Preview {
    return HomeViewController()
}
