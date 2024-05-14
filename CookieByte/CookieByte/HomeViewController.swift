//
//  ViewController.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 14/05/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let tittleLabel: UILabel = {
       let tittleLabel = UILabel()
         
        tittleLabel.text = "Favoritos"
        tittleLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        tittleLabel.textColor = .black
        tittleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return tittleLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Bem-vindo"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: nil, action: nil)
        
        setElements()
    }
    
    func setElements(){
        setTitleLabel()
    }

    func setTitleLabel(){
        self.view.addSubview(tittleLabel)
        
        NSLayoutConstraint.activate([
            tittleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            tittleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            tittleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }

}

#Preview(){
    return HomeViewController()
}