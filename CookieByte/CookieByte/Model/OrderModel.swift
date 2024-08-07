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
    let price: Double
    var qnt: Int = 1
    let pic: UIImage?
    let status: Bool
    let color: UIColor?
}

class Order {
    static var shared = Order()
    
    var orders: [OrderModel] = [
        OrderModel(user: "Gabriel", cookie: "Cookie Chocolate", date: Date(), price: 4.0, qnt: 1, pic: UIImage(named: "CookieT"), status: true, color: UIColor(named: "Cookie1Back")),
    ]
    
    init() {}
    
    func addOrder(_ newOrder: OrderModel) {
        if let index = orders.firstIndex(where: { $0.cookie == newOrder.cookie }) {
            orders[index].qnt += newOrder.qnt
        } else {
            orders.append(newOrder)
        }
        print("Current orders after adding: \(orders)") // Adicione este print
        NotificationCenter.default.post(name: NSNotification.Name("OrderUpdated"), object: nil)
    }
    
    func removeCompletedOrders() {
        orders.removeAll { $0.status }
    }

    func removeOrder(at index: Int){
        if index < orders.count {
            orders.remove(at: index)
            NotificationCenter.default.post(name: NSNotification.Name("OrderUpdated"), object: nil)
            print("Pedidos restantes: \(orders)")
        }
    }
}
