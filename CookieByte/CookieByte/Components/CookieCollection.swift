//
//  CookieCard.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 15/05/24.
//

import UIKit

class CookieCollection: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Icone de carrinho
    var viewController: HomeViewController?
    var icon: IconCartDelegate = IconCartDelegate()
    
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
        
        // Carregar cookies e atualizar a coleção
        Cookies.cookieShared.loadCookies { [weak self] in
            DispatchQueue.main.async {
                self?.cookieCard.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cookies.cookieShared.cookie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cookie = Cookies.cookieShared.cookie[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // Limpa as subviews anteriores
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Container view para aplicar a sombra
        let containerView = UIView(frame: cell.contentView.bounds)
        
        cell.layer.shadowColor = UIColor.black.cgColor
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
        priceLabel.text = String(format: "R$ %.2f", cookie.price)
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
        
        let cookie = Cookies.cookieShared.cookie[indexPath.row]
        
        let popup = CookiePopUp()
        popup.configure(with: cookie)
        
        // Icone de carrinho
        popup.viewController = self.viewController
        icon.viewController = self.viewController
        
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(popup)
            CookieController.animateIn(view: popup, container: popup)
        }
    }
}

class Cookies {
    static var cookieShared = Cookies()

    var cookie: [CookiesModel] = []

    func loadCookies(completion: @escaping () -> Void) {
        let urlString = "https://raw.githubusercontent.com/igorbraganca2003/CookieByte/dev/cookies.json"
        guard let url = URL(string: urlString) else {
            print("URL inválida")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Erro na requisição: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Dados não disponíveis")
                return
            }

            do {
                let decoder = JSONDecoder()
                let cookies = try decoder.decode([CookiesModel].self, from: data)
                DispatchQueue.main.async {
                    self.cookie = cookies
                    completion()
                }
            } catch {
                print("Erro ao fazer parse do JSON: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}
