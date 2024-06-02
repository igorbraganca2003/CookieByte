//
//  CookieController.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 31/05/24.
//

import UIKit

class CookieController: UIView {
    
    var cookiePop: CookiePopUp = CookiePopUp()
    
    // Icone de carrinho
    let delegate: IconCartDelegate = IconCartDelegate()
    var viewController: HomeViewController?
    
    var currentCookie: CookiesModel?
    
    
    //MARK: - Funções de animações
    
    static func animateIn(view: UIView, container: UIView) {
        container.transform = CGAffineTransform(translationX: 0, y: -view.frame.height)
        view.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, animations: {
            container.transform = .identity
            view.alpha = 1
        })
    }
    
    static func animateOut(view: UIView, container: UIView, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, animations: {
            container.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
            view.alpha = 0
        }) { complete in
            if complete {
                view.removeFromSuperview()
                completion?()
            }
        }
    }
    
    
    //MARK: - PixPopUp
    
    // Atualiza o preço no popUp do pix
    static func updateTotalPrice(label: UILabel) {
        let totalPrice = Order.shared.orders.reduce(into: 0) { $0 + ($1.price * Float($1.qnt)) }
        print("Total price: \(totalPrice)")  // Para depuração
        if totalPrice > 0 {
            label.text = String(format: "Total: R$ %.2f", totalPrice)
        } else {
            label.text = "R$ 0,00"
        }
    }
    
    //Confirma o pagamento
    static func payConfirmed(from view: UIView) {
        let popup = DonePopUp()
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(popup)
            animateIn(view: popup, container: popup)
        }
        
        Order.shared.removeCompletedOrders()
        
        view.removeFromSuperview()
    }
    
    
    //MARK: - Função carrinho
    
    @objc static func payButtonTapped() {
        let popup = PixPopUp()
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(popup)
            animateIn(view: popup, container: popup)
        }
        print("Botão de compra pressionado")
        CartPopUp().removeFromSuperview()
    }
    
    // Carrega os itens do carrinho
    func loadCartItems() {
        CartPopUp().cartCollectionView.reloadData()
    }
    
    
    //MARK: - Funções do CookiePopUp
    
    func configure(with cookie: CookiesModel) {
        cookiePop.currentCookie = cookie
        
        if let originalImage = UIImage(named: cookie.pic) {
            let newSize = CGSize(width: originalImage.size.width * 0.4, height: originalImage.size.height * 0.4)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            originalImage.draw(in: CGRect(origin: .zero, size: newSize))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let resizedImage = resizedImage {
                cookiePop.imageCookie.image = resizedImage
            } else {
                print("Erro ao redimensionar a imagem")
                cookiePop.imageCookie.image = originalImage
            }
        } else {
            print("Erro ao carregar a imagem original")
            cookiePop.imageCookie.image = nil
        }
        
        cookiePop.label.text = cookie.cookieName
        cookiePop.priceLabel.text = String(format: "R$ %.2f", cookie.price)
        cookiePop.descLabel.text = cookie.description
        cookiePop.imageCookie.backgroundColor = cookie.color
        
        updateHeartButton()
    }
    
    @objc func toggleFavorite() {
        guard var cookie = cookiePop.currentCookie else { return }
        cookie.isFavorite.toggle()
        cookiePop.currentCookie = cookie
        updateHeartButton()
    }
    
    func updateHeartButton() {
        guard let cookie = cookiePop.currentCookie else { return }
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        let buttonImageName = cookie.isFavorite ? "heart.fill" : "heart"
        let buttonImage = UIImage(systemName: buttonImageName, withConfiguration: config)
        cookiePop.heartButton.setImage(buttonImage, for: .normal)
    }
    
    @objc func payButton() {
        let popup = PixPopUp()
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(popup)
            CookieController.animateIn(view: popup, container: popup)
        }
        print("Botão de compra pressionado")
    }
    
    static func addToCart(from cookiePop: CookiePopUp) {
        guard let cookieName = cookiePop.label.text,
              let cookieImage = cookiePop.imageCookie.image,
              let cookieBack = cookiePop.imageCookie.backgroundColor,
              let priceText = cookiePop.priceLabel.text,
              let price = Float(priceText.replacingOccurrences(of: "R$ ", with: "").replacingOccurrences(of: ",", with: ".")) else {
            return
        }
        
        let newOrder = OrderModel(user: nil, cookie: cookieName, date: Date(), price: price, qnt: CookieController().quantity, pic: cookieImage, status: true, color: cookieBack)
        Order.shared.addOrder(newOrder)
        print("Pedido adicionado: \(newOrder)")
        
        let popup = CartPopUp()
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(popup)
            CookieController.animateIn(view: popup, container: popup)
        }
        
        cookiePop.removeFromSuperview()
    }
    
    
    //MARK: - Calculo de quantidade do carrinho
    var quantity = 1 {
        didSet {
            CartCard().qntLabel.text = "\(quantity)"
        }
    }
    
    @objc func incrementQuantity() {
        quantity += 1
    }
    
    @objc func decrementQuantity() {
        if quantity > 1 {
            quantity -= 1
        }
    }
    
}





//MARK: - Altera o icone do carrinho
class IconCartDelegate {
    var uiView: CookiePopUp?
    var viewController: HomeViewController?
    
    func changeIcon(){
        viewController?.navigationItem.rightBarButtonItems?[1].isHidden = true
        viewController?.navigationItem.rightBarButtonItems?[0].isHidden = true
        print("chamou")
    }
}
