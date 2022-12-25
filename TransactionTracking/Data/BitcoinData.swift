//
//  BitcoinData.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 25.12.2022.
//

import Foundation

// MARK: - Welcome
struct BitcoinData: Codable {
    let time: Time
    let disclaimer, chartName: String
    let bpi: ValueCurrency
}

// MARK: - Bpi
struct ValueCurrency: Codable {
    let usd, gbp, eur: Сurrency

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

// MARK: - Eur
struct Сurrency: Codable {
    let code, symbol, rate, eurDescription: String
    let rateFloat: Double

    enum CodingKeys: String, CodingKey {
        case code, symbol, rate
        case eurDescription = "description"
        case rateFloat = "rate_float"
    }
}

// MARK: - Time
struct Time: Codable {
    let updated: String
    let updatedISO: Date
    let updateduk: String
}
