//
//  BTCPriceModel.swift
//  CryptoShow
//
//  Created by Sylvain on 20/03/2025.
//

import Foundation

// Modèle pour représenter les informations d'une cryptomonnaie
struct CryptoCurrency: Decodable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let current_price: Double?
    let price_change_percentage_24h: Double?
    let market_cap: Double?
    let total_volume: Double?
}
