//
//  BalanceService.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 26.12.2022.
//

import Foundation

class BalanceService {
    
    private var dataManager = DataManager()
    
    func changeBalance(amount: Int, type: TransactionType) {
        var newBalance: Double
        switch type {
        case .replenish:
            newBalance = (dataManager.balance.last?.amount ?? 0) + Double(amount)
        default:
            newBalance = (dataManager.balance.last?.amount ?? 0) - Double(amount)
        }
        dataManager.saveBalance(amount: newBalance)
    }
    
    func getBalance() -> String {
        return "\(dataManager.balance.last?.amount ?? 0)"
    }
    
}
