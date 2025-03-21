import Foundation
import Combine

class CryptoPriceViewModel: ObservableObject {
    @Published var cryptos: [Crypto] = []
    @Published var favorites: [Crypto] = [] // Ajout de la propriété favorites
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var sortOption: SortOption = .name

    private var cancellables = Set<AnyCancellable>()
    private let cryptoService = CryptoService()

    func loadCryptoPrices() {
        isLoading = true
        errorMessage = nil

        cryptoService.fetchAllCryptos()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = "Erreur: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] cryptos in
                self?.cryptos = cryptos
            })
            .store(in: &cancellables)
    }

    func toggleFavorite(crypto: Crypto) {
        if let index = favorites.firstIndex(where: { $0.id == crypto.id }) {
            favorites.remove(at: index)
        } else {
            favorites.append(crypto)
        }
    }

    func sortCryptos() {
        switch sortOption {
        case .name:
            cryptos.sort { $0.name < $1.name }
        case .price:
            cryptos.sort { $0.current_price > $1.current_price }
        case .marketCap:
            cryptos.sort { ($0.market_cap ?? 0) > ($1.market_cap ?? 0) }
        }
    }
}

enum SortOption {
    case name, price, marketCap
}