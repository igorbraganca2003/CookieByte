//
//  CookieModel.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 14/05/24.
//

import Foundation
import UIKit

struct CookiesModel{
    let cookieName: String
    let price: Float
    let color: UIColor
    let pic: String
    let description: String
    var isFavorite: Bool
}

class Cookies{
    static var cookieShared = Cookies()
    
    let cookie: [CookiesModel] = [
        CookiesModel(cookieName: "Cookie Chocolate", price: 4.00, color: UIColor(named: "Cookie1Back")!, pic: "CookieT", description: "Cookies tradicionais, contém: Açúcar, Açúcar Mascavo, Sal, Manteiga, Ovos, Farinha, Baunilha, Gotas de Chocolate", isFavorite: false),
        
        CookiesModel(cookieName: "Cookie M&M's", price: 4.00, color: UIColor(named: "Cookie2Back")!, pic: "CookieM", description: "Cookies M&M's, contém: Açúcar, Açúcar Mascavo, Sal, Manteiga, Ovos, Farinha, Baunilha, Gotas de Chocolate, Confeitos M&M's.", isFavorite: false),
        
        CookiesModel(cookieName: "Cookie Branco", price: 4.00, color: UIColor(named: "Cookie3Back")!, pic: "CookieB", description: "Cookies Chocolate Branco, contém: Açúcar, Açúcar Mascavo, Sal, Manteiga, Ovos, Farinha, Baunilha, pedaço de chocolate branco", isFavorite: false),
        
        CookiesModel(cookieName: "Cookie Nutella", price: 6.00, color: UIColor(named: "Cookie4Back")!, pic: "CookieN", description: "Cookies recheado de Nutella, contém: Açúcar, Açúcar Mascavo, Sal, Manteiga, Ovos, Farinha, Baunilha, Creme de Avelã Nutella", isFavorite: true),
        
        CookiesModel(cookieName: "Ck Nutella & Morango", price: 8.00, color: UIColor(named: "Cookie5Back")!, pic: "CookieNM", description: "Cookies Nutella com morango, contém: Açúcar, Açúcar Mascavo, Sal, Manteiga, Ovos, Farinha, Baunilha, Creme de Avelã Nutella e morangos", isFavorite: true)
    ]
    
    init() {}
}

