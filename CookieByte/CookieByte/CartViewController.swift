//
//  CartViewController.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 23/05/24.
//

import UIKit

class CartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let cartPopUp = CartPopUp()
        cartPopUp.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(cartPopUp)

        NSLayoutConstraint.activate([
            cartPopUp.topAnchor.constraint(equalTo: view.topAnchor),
            cartPopUp.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cartPopUp.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartPopUp.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

