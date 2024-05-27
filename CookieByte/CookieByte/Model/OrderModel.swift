//
//  OrderModel.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 14/05/24.
//

import Foundation

struct OrderModel {
    let user: String?
    let cookie: String
    let date: Date
    let price: Float
    let qnt: Int
    let status: Bool
}

class Order {
    static var shared = Order()
    var orders: [OrderModel] = [
        OrderModel(user: "ölas", cookie: "Cookie1", date: Date(), price: 4.0, qnt: 1, status: true),
        OrderModel(user: "ölas", cookie: "Cookie2", date: Date(), price: 4.0, qnt: 1, status: true),
        OrderModel(user: "ölas", cookie: "Cookie2", date: Date(), price: 4.0, qnt: 1, status: true),
        OrderModel(user: "ölas", cookie: "Cookie2", date: Date(), price: 4.0, qnt: 1, status: true),
        OrderModel(user: "ölas", cookie: "Cookie2", date: Date(), price: 4.0, qnt: 1, status: true),
        OrderModel(user: "ölas", cookie: "Cookie2", date: Date(), price: 4.0, qnt: 1, status: true),
        OrderModel(user: "ölas", cookie: "Cookie2", date: Date(), price: 4.0, qnt: 1, status: true),
        OrderModel(user: "ölas", cookie: "Cookie2", date: Date(), price: 4.0, qnt: 1, status: true)
    ]
    
    init() {}
    
    func addOrder(_ order: OrderModel) {
        orders.append(order)
    }
}
