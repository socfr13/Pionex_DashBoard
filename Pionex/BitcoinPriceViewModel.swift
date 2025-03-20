//
//  BitcoinPriceViewModel.swift
//  CryptoShow
//
//  Created by Sylvain on 20/03/2025.
//

import Foundation
import Combine

class BitcoinPriceViewModel: ObservableObject {
    @Published var price: Double?
    @Published var errorMessage: String?
    private var cancellables: Set<AnyCancellable> = []

    func fetchBTCPrice() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=eur") else {
            errorMessage = "URL invalide"
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: BTCPrice.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Erreur de récupération du prix: \(error.localizedDescription)"
                    if let decodingError = error as? DecodingError { // Conversion de type conditionnelle (as?)
                        switch decodingError { // Switch pour gérer les différents cas de DecodingError (optionnel)
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
                self.price = btcPrice.btc.eur
                self.errorMessage = nil // Effacer les erreurs précédentes en cas de succès
            }), receiveValue: { btcPrice in
                self.price = btcPrice.btc.eur
                self.errorMessage = nil // Effacer les erreurs précédentes en cas de succès
            })
            .store(in: &cancellables)
    }
}
