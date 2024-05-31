////
////  ViewController.swift
////  CookieByte
////
////  Created by Igor Bragança Toledo on 14/05/24.
////
//
//import UIKit
//
//class HomeViewController: UIViewController {
//    
//    let labels: [String] = ["1", "2", "3"]
//    
//    let labelsContainerView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.alignment = .leading
//        stackView.spacing = 8 // Espaçamento entre as labels
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.title = "Bem-vindo"
//        self.view.backgroundColor = .white
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: nil, action: nil)
//        
//        setElements()
//    }
//    
//    func setElements(){
////        setTitleLabel()
//        setupLabels()
//    }
//    
//    func setupLabels() {
//        // Adicionando cada label ao container
//        for labelText in labels {
//            let tittleLabel = UILabel()
//            tittleLabel.text = labelText
//            tittleLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
//            tittleLabel.textColor = .black
//            
//            // Adicionando a label ao container
//            labelsContainerView.addArrangedSubview(tittleLabel)
//        }
//        
//        // Layout do container
//        view.addSubview(labelsContainerView)
//        NSLayoutConstraint.activate([
//            labelsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            labelsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            labelsContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100) // Posição da parte superior do container
//        ])
//    }
//    
////    func setTitleLabel(){
////        self.view.addSubview(tittleLabel)
////
////        NSLayoutConstraint.activate([
////            tittleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
////            tittleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
////            tittleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20)
////        ])
////    }
//    
//}
//
//#Preview(){
//    return HomeViewController()
//}
