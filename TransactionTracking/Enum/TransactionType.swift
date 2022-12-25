//
//  TransactionType.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 25.12.2022.
//

import Foundation

//    MARK: - TransactionType
enum TransactionType {
    case groceries
    case taxi
    case electronic
    case restaurant
    case other
    case replenish
    
    var title: String {
        switch self {
        case .groceries: return "Groceries"
        case .taxi: return "Taxi"
        case .electronic: return "Electronic"
        case .restaurant: return "Restaurant"
        case .other: return "Other"
        case .replenish: return "Replenish"
        }
    }
}
