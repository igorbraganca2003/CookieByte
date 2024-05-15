//
//  CookieCard.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 15/05/24.
//
import UIKit

class CookieCard: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Inicializando a UICollectionView com um layout
    private let cookieCard: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.minimumLineSpacing = 30
        
        let card = UICollectionView(frame: .zero, collectionViewLayout: layout)
        card.backgroundColor = UIColor.white
        card.showsHorizontalScrollIndicator = false
        card.translatesAutoresizingMaskIntoConstraints = false
        
        return card
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cookies().cookie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let cookie = Cookies().cookie[indexPath.row]
        
        cell.backgroundColor = cookie.color
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 10, height: 10)
        cell.layer.shadowRadius = 0
        cell.layer.shadowOpacity = 1
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.image = UIImage(named: cookie.pic)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true

        let imageViewWidth = cell.frame.width - 30
        let imageViewHeight = cell.frame.height - 30

        let xPosition = (cell.contentView.frame.width - imageViewWidth) / 2
        let yPosition = (cell.contentView.frame.height - imageViewHeight) / 2

        imageView.frame = CGRect(x: xPosition, y: yPosition, width: imageViewWidth, height: imageViewHeight)

        cell.contentView.addSubview(imageView)

        return cell

    }
    
//    let imageView = UIImageView(frame: cell.contentView.bounds)
//    imageView.image = UIImage(named: cookie.pic)
//    imageView.frame = CGRect(origin: cell.anchorPoint, size: CGSize(width: cell.frame.width - 10, height: cell.frame.height-10))
//    imageView.center = cell.center
//    imageView.contentMode = .scaleAspectFit
//    imageView.clipsToBounds = true
//    
//    cell.contentView.addSubview(imageView)

}

#Preview(){
    return CookieCard()
}
