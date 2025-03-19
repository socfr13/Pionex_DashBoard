import SwiftUI
import Combine

final class CryptoViewModel: ObservableObject {
    @Published var cryptos: [CryptoModel] = []
    @Published var selectedCryptos: [CryptoModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    private var selectionManager: CryptoSelectionManager
    private var cancellables = Set<AnyCancellable>()
    
    init(selectionManager: CryptoSelectionManager) {
        self.selectionManager = selectionManager

        // Ajout d'un écouteur sur `cryptos` pour recharger les cryptos sélectionnées dès qu'elles arrivent
        $cryptos
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.loadSelectedCryptos()
            }
            .store(in: &cancellables)
    }

    func fetchMarketData() {
        self.isLoading = true
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let dummyData = [
                CryptoModel(name: "Bitcoin", symbol: "BTC", price: 67000, timestamp: Date()),
                CryptoModel(name: "Ethereum", symbol: "ETH", price: 3800, timestamp: Date())
            ]
            DispatchQueue.main.async {
                self.cryptos = dummyData
                self.loadSelectedCryptos()  // ✅ Ajout du chargement après la récupération des données
                self.isLoading = false
            }
        }
    }

    func loadSelectedCryptos() {
        print("🔵 Chargement des cryptos sélectionnées...")

        guard !cryptos.isEmpty else {
            print("⚠️ Aucune crypto disponible, tentative de rechargement...")
            return
        }

        selectedCryptos = cryptos.filter { crypto in
            selectionManager.selectedCryptos.contains(crypto.symbol.lowercased())
        }

        print("🟢 Cryptos sélectionnées chargées : \(selectedCryptos.map { $0.name })")
        print("🔍 Vérification : \(selectedCryptos.count) cryptos sélectionnées")
    }
}

struct CryptoModel: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let price: Double
    let timestamp: Date
}
