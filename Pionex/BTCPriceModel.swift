//
//  BTCPriceModel.swift
//  CryptoShow
//
//  Created by Sylvain on 20/03/2025.
//

import Foundation

// Modèle pour représenter le prix du BTC et les informations de devise
struct BTCPrice: Decodable {
    let btc: CurrencyPrice
}

struct CurrencyPrice: Decodable {
    let eur: Double
}
