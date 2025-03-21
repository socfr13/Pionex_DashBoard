import Foundation

struct Crypto: Identifiable, Decodable {
    let id: String
    let symbol: String
    let name: String
    let current_price: Double
    let image: String
    let market_cap: Double
    let total_volume: Double
    let price_change_percentage_24h: Double
}
