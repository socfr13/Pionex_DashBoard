import Foundation

struct CryptoSymbol: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
}

class CryptoListService: ObservableObject {
    @Published var availableCryptos: [CryptoSymbol] = []
    
    func fetchAvailableCryptos() {
        let urlString = "https://api.coingecko.com/api/v3/coins/list"

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
                let decodedData = try JSONDecoder().decode([CryptoSymbol].self, from: data)
                DispatchQueue.main.async {
                    self.availableCryptos = decodedData
                    print("✅ [SUCCÈS] \(decodedData.count) cryptos chargées")
                }
            } catch {
                print("❌ [ERREUR] Erreur de parsing JSON : \(error.localizedDescription)")
            }
        }.resume()
    }
}
