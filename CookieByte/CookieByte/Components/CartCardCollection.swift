//
//  CartCardCell.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 26/05/24.
//

import UIKit

class CartCardCollection: UICollectionViewCell {
    var cartCard: CartCard
    
    override init(frame: CGRect) {
        self.cartCard = CartCard()
        super.init(frame: frame)
        
        self.addSubview(cartCard)
        cartCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cartCard.topAnchor.constraint(equalTo: self.topAnchor),
            cartCard.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cartCard.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cartCard.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
