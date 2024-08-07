//
//  PointsController.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 01/08/24.
//

import Foundation

class PointsController {
    static let shared = PointsController()
    
    init() {
        // Carrega o valor dos pontos e a data da última reinicialização
        userPts = UserDefaults.standard.integer(forKey: "userPts")
        lastResetDate = UserDefaults.standard.object(forKey: "lastResetDate") as? Date ?? Date.distantPast
        
        // Verifica se a data atual é um novo mês
        checkAndResetPointsIfNeeded()
    }

    var userPts: Int = 0 {
        didSet {
            UserDefaults.standard.set(userPts, forKey: "userPts")
            NotificationCenter.default.post(name: .pointsDidChange, object: nil)
        }
    }

    private var lastResetDate: Date {
        didSet {
            UserDefaults.standard.set(lastResetDate, forKey: "lastResetDate")
        }
    }
    
    let status: Bool = true
    let numbers = [10, 25, 40, 60, 80]
    let pointsDesc = ["50% de desconto em 1 (um) cookie Tradicional", "1 (um) Cookie Tradicional", "50% desconto na sua próxima compra", "1 (um) Cookie recheado de Nutella", "1 (um) Cookie de Nutella e Morango + 1 (um) Brownie"]
    let pointsPerReal: Int = 1
    
    func addPoints() {
        let orders = Order.shared.orders
        print("Current orders: \(orders)")
        
        let totalPrice = orders.reduce(0) { $0 + ($1.price * Double($1.qnt)) }
        print("Total price of orders: \(totalPrice)")
        
        let pointsToAdd = Int(totalPrice) * pointsPerReal
        print("Points to add: \(pointsToAdd)")
        
        userPts += pointsToAdd
        print("Você ganhou: \(pointsToAdd) pontos. Total de pontos: \(userPts)")
    }
    
    private func checkAndResetPointsIfNeeded() {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let lastResetComponents = calendar.dateComponents([.year, .month], from: lastResetDate)
        let currentComponents = calendar.dateComponents([.year, .month], from: currentDate)
        
        if lastResetComponents != currentComponents {
            resetPoints()
            lastResetDate = currentDate
        }
    }
    
    private func resetPoints() {
        userPts = 0
        print("Os pontos foram zerados.")
    }
}

extension Notification.Name {
    static let pointsDidChange = Notification.Name("pointsDidChange")
}
