//
//  BitcoinPriceViewModel.swift
//  CryptoShow
//
//  Created by Sylvain on 20/03/2025.
//

import Foundation
import Combine

struct Crypto: Decodable {
    let id: String
    let symbol: String
    let name: String
    let current_price: Double
    let market_cap: Double
    let price_change_percentage_24h: Double
}

typealias CryptoList = [Crypto]

struct BTCPrice: Decodable {
    struct Currency: Decodable {
        let eur: Double
    }
    let bitcoin: Currency
}

class BitcoinPriceViewModel: ObservableObject {
    @Published var price: Double?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    private var cancellables: Set<AnyCancellable> = []

    func fetchBTCPrice() {
        isLoading = true
        guard let url = URL(string: "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=eur") else {
            errorMessage = "URL invalide"
            isLoading = false
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: BTCPrice.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Erreur de récupération du prix: \(error.localizedDescription)"
                    if let decodingError = error as? DecodingError { // Vérification si l'erreur est de type DecodingError
                        switch decodingError { // Gestion des différents types d'erreurs de décodage JSON
                        case .dataCorrupted(let context):
                            self.errorMessage = "Erreur de données corrompues: \(context.debugDescription)"
                        case .keyNotFound(let key, let context):
                            self.errorMessage = "Clé JSON non trouvée: \(key.stringValue), \(context.debugDescription)"
                        case .typeMismatch(let type, let context):
                            self.errorMessage = "Type JSON incorrect: \(type), \(context.debugDescription)"
                        case .valueNotFound(let type, let context):
                            self.errorMessage = "Valeur JSON non trouvée: \(type), \(context.debugDescription)"
                        default:
                            self.errorMessage = "Erreur de décodage JSON inconnue."
                        }
                    } else if (error as NSError).domain == NSURLErrorDomain && (error as NSError).code == NSURLErrorNotConnectedToInternet {
                        self.errorMessage = "Pas de connexion Internet. Veuillez vérifier votre connexion réseau."
                    }
                case .finished:
                    break
                }
            }, receiveValue: { btcPrice in
                self.price = btcPrice.bitcoin.eur
                self.errorMessage = nil // Effacer les erreurs précédentes en cas de succès
            })
            .store(in: &cancellables)
    }
}

class CryptoPriceViewModel: ObservableObject {
    @Published var cryptos: [Crypto] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    private var cancellables: Set<AnyCancellable> = []

    func fetchCryptoPrices() {
        isLoading = true
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=10&page=1&sparkline=false") else {
            errorMessage = "URL invalide"
            isLoading = false
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CryptoList.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = "Erreur: \(error.localizedDescription)"
                }
            }, receiveValue: { cryptos in
                self.cryptos = cryptos
                self.errorMessage = nil
            })
            .store(in: &cancellables)
    }
}
