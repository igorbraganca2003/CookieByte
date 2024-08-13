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
    let numbers = [10, 20, 35, 50, 70]
    let pointsDesc = ["50% de desconto em 1 (um) cookie Tradicional", "1 (um) Cookie Tradicional", "1 (um) Cookie de Nutella", "1 (um) Cookie de Nutella e Morango", "2 (dois) Cookie de Nutella e Morango"]
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
    
    func rescuePrize() {
        // Encontre o índice do prêmio mais alto que o usuário pode resgatar
        guard let prizeIndex = numbers.lastIndex(where: { userPts >= $0 }) else {
            print("Nenhum prêmio disponível para a pontuação atual.")
            return
        }
        
        // Verifique se o índice encontrado está dentro do intervalo dos prêmios disponíveis
        if prizeIndex < Order.shared.prize.count {
            var prizeOrder = Order.shared.prize[prizeIndex]
            let pointsSpent = numbers[prizeIndex]
            
            prizeOrder.qnt = 1 // Certifique-se de que a quantidade seja 1
            Order.shared.addOrder(prizeOrder)
            userPts -= pointsSpent
            print("Resgatado: \(prizeOrder.cookie). Pontos gastos: \(pointsSpent). Pontos restantes: \(userPts)")
        } else {
            print("Prêmio não encontrado.")
        }
    }
}

extension Notification.Name {
    static let pointsDidChange = Notification.Name("pointsDidChange")
}
