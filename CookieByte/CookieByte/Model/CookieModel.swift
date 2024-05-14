//
//  CookieModel.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 14/05/24.
//

import Foundation

struct CookiesModel{
    let cookieName: String
    let price: Float
    let description: String
    let isFavorite: Bool
}

struct Cookies{
    let cookie: [CookiesModel] = [
        CookiesModel(cookieName: "Cookie Tradicional", price: 4.0, description: "Cookies tradicionais, contém: Açúcar, Açúcar Mascavo, Sal, Manteiga, Ovos, Farinha, Baunilha, Gotas de Chocolate", isFavorite: false),
        CookiesModel(cookieName: "Cookie M&M's", price: 4.0, description: "Cookies M&M's, contém: Açúcar, Açúcar Mascavo, Sal, Manteiga, Ovos, Farinha, Baunilha, Gotas de Chocolate, Confeitos M&M's.", isFavorite: false),
        CookiesModel(cookieName: "Cookie Chocolate Branco", price: 4.0, description: "Cookies Chocolate Branco, contém: Açúcar, Açúcar Mascavo, Sal, Manteiga, Ovos, Farinha, Baunilha, pedaço de chocolate branco", isFavorite: false)
    ]
}
