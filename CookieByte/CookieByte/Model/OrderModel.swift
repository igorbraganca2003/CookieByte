//
//  OrderModel.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 14/05/24.
//

import Foundation

struct OrderModel {
    let user: String
    let cookie: String
    let date: Date
    let price: Float
    let qnt: Int
    let status: Bool
}

class Order {
    static var shared = Order()
    private(set) var orders: [OrderModel] = []
    
    private init() {}
    
    func addOrder(_ order: OrderModel) {
        orders.append(order)
    }
}
