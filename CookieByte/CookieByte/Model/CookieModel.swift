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
    let isFavorite: Bool
}

class Cookies{
    static var cookieShared = Cookies()
    
    let cookie: [CookiesModel] = [
        CookiesModel(cookieName: "Cookie Tradicional", price: 4.00, color: UIColor(named: "Cookie1Back")!, pic: "CookieT", description: "Cookies tradicionais, contém: Açúcar, Açúcar Mascavo, Sal, Manteiga, Ovos, Farinha, Baunilha, Gotas de Chocolate", isFavorite: false),
        
        CookiesModel(cookieName: "Cookie M&M's", price: 4.00, color: UIColor(named: "Cookie2Back")!, pic: "CookieM", description: "Cookies M&M's, contém: Açúcar, Açúcar Mascavo, Sal, Manteiga, Ovos, Farinha, Baunilha, Gotas de Chocolate, Confeitos M&M's.", isFavorite: false),
        
        CookiesModel(cookieName: "Cookie Branco", price: 4.00, color: UIColor(named: "Cookie3Back")!, pic: "CookieB", description: "Cookies Chocolate Branco, contém: Açúcar, Açúcar Mascavo, Sal, Manteiga, Ovos, Farinha, Baunilha, pedaço de chocolate branco", isFavorite: true)
    ]
    
    init() {}
}
