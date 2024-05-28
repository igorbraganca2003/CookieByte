//
//  OrderModel.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 14/05/24.
//

import UIKit

struct OrderModel {
    let user: String?
    let cookie: String
    let date: Date
    let price: Float
    let qnt: Int
    let pic: UIImage?
    let status: Bool
    let color: UIColor?
}

class Order {
    static var shared = Order()
    var orders: [OrderModel] = [
//                OrderModel(user: "Gabriel", cookie: "Cookie1", date: Date(), price: 4.0, qnt: 1, pic: UIImage(named: "CookieT"), status: true, color: UIColor(named: "Cookie1Back")),
        //        OrderModel(user: "Lucas", cookie: "Cookie2", date: Date(), price: 4.0, qnt: 1, pic: UIImage(named: "CookieB"), status: true, color: UIColor(named: "Cookie2Back"))
    ]
    
    init() {}
    
    func addOrder(_ order: OrderModel) {
        orders.append(order)
    }
    
    func removeCompletedOrders() {
        orders.removeAll { $0.status }
    }
}
