import Foundation
import Combine

struct CoinGeckoResponse: Codable {
    let market_data: MarketData?
}

struct MarketData: Codable {
    let current_price: [String: Double]?
    let market_cap: [String: Double]?
    let total_volume: [String: Double]?
    let price_change_percentage_24h: Double?
}

class CryptoService: ObservableObject {
    @Published var cryptoData: [String: MarketData] = [:]
    @Published var sortedCryptoList: [(symbol: String, data: MarketData)] = []
    @Published var selectedCrypto: String = "bitcoin"

    func fetchMarketData(for symbol: String) {
        let coinId = symbol.lowercased()
        let urlString = "https://api.coingecko.com/api/v3/coins/\(coinId)?localization=false&tickers=false&market_data=true"

        guard let url = URL(string: urlString) else {
            print("❌ [ERREUR] URL invalide")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ [ERREUR] Échec de la requête API : \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("❌ [ERREUR] Aucune donnée reçue depuis CoinGecko")
                return
            }

            do {
                let response = try JSONDecoder().decode(CoinGeckoResponse.self, from: data)
                DispatchQueue.main.async {
                    if let marketData = response.market_data {
                        self.cryptoData[symbol] = marketData
                        self.sortCryptoList()
                        print("✅ [SUCCÈS] Données récupérées pour \(symbol)")
                    } else {
                        print("⚠️ [ATTENTION] Pas de market_data pour \(symbol)")
                    }
                }
            } catch {
                print("❌ [ERREUR] Erreur de parsing JSON : \(error.localizedDescription)")
            }
        }.resume()
    }

    private func sortCryptoList() {
        sortedCryptoList = cryptoData
            .filter { $0.key.uppercased().hasSuffix("USDT") }  // Filtrer les paires USDT
            .map { (symbol: $0.key, data: $0.value) }          // Transformer en tuples avec les bons noms
            .sorted { $0.symbol.localizedCaseInsensitiveCompare($1.symbol) == .orderedAscending }  // Tri alphabétique
    }

    func fetchCryptos(page: Int) -> AnyPublisher<[Crypto], Error> {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=10&page=\(page)&sparkline=false")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Crypto].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchAllCryptos() -> AnyPublisher<[Crypto], Error> {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=1&sparkline=false")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Crypto].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
