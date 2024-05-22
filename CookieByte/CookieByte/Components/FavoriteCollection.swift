//
//  FavoriteCollection2.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 22/05/24.
//

import UIKit

class FavoriteCollection: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var favoriteCookies: [CookiesModel] = []
    
    // Objetos
    private let cookieCard: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.minimumLineSpacing = 40
        
        let card = UICollectionView(frame: .zero, collectionViewLayout: layout)
        card.backgroundColor = UIColor.white
        card.showsHorizontalScrollIndicator = false
        card.translatesAutoresizingMaskIntoConstraints = false
        card.contentInset = UIEdgeInsets(top: -60, left: 20, bottom: 0, right: 30)
        
        return card
    }()
    
    // Tela
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // Funções
    private func commonInit() {
        addSubview(cookieCard)
        
        NSLayoutConstraint.activate([
            cookieCard.topAnchor.constraint(equalTo: topAnchor),
            cookieCard.leadingAnchor.constraint(equalTo: leadingAnchor),
            cookieCard.trailingAnchor.constraint(equalTo: trailingAnchor),
            cookieCard.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        cookieCard.delegate = self
        cookieCard.dataSource = self
        cookieCard.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        // Filtra os cookies favoritos
        let allCookies = Cookies().cookie
        favoriteCookies = allCookies.filter { $0.isFavorite }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteCookies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cookie = favoriteCookies[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // Limpa as subviews anteriores
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Container view para aplicar a sombra
        let containerView = UIView(frame: cell.contentView.bounds)
        containerView.backgroundColor = cookie.color
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.backgroundColor = cookie.color
        cell.layer.borderWidth = 5
        
        containerView.layer.shadowOffset = CGSize(width: 10, height: 10)
        containerView.layer.shadowRadius = 0
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.masksToBounds = false
        
        let imageView = UIImageView(frame: containerView.bounds)
        imageView.image = UIImage(named: cookie.pic)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        let imageViewWidth = containerView.frame.width - 30
        let imageViewHeight = containerView.frame.height - 30
        let xPosition = (containerView.frame.width - imageViewWidth) / 2
        let yPosition = (containerView.frame.height - imageViewHeight) / 2
        
        imageView.frame = CGRect(x: xPosition, y: yPosition, width: imageViewWidth, height: imageViewHeight)
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: containerView.frame.height + 10, width: containerView.frame.width, height: 40))
        nameLabel.text = "\(cookie.cookieName)"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .black)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        
        let priceLabel = UILabel(frame: CGRect(x: 0, y: containerView.frame.height + 10, width: containerView.frame.width, height: 100))
        priceLabel.text = "R$ \(cookie.price)"
        priceLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .left
        
        containerView.addSubview(imageView)
        cell.addSubview(nameLabel)
        cell.addSubview(priceLabel)
        cell.contentView.addSubview(containerView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showCookiePopUp(_:)))
        cell.addGestureRecognizer(tapGesture)
        
        return cell
    }
    
    @objc func showCookiePopUp(_ sender: UITapGestureRecognizer) {
        guard let cell = sender.view as? UICollectionViewCell else { return }
        guard let indexPath = cookieCard.indexPath(for: cell) else { return }
        
        let cookie = Cookies().cookie[indexPath.row]
        
        let popup = CookiePopUp()
        popup.configure(with: cookie)
        
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(popup)
            popup.animateIn()
        }
    }
    
}
