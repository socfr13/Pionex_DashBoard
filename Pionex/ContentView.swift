import SwiftUI

struct ContentView: View {
    @StateObject private var selectionManager = CryptoSelectionManager()
    @StateObject private var viewModel: CryptoViewModel
    @State private var showSelectionView = false
    
    init() {
        let selectionManager = CryptoSelectionManager()
        _viewModel = StateObject(wrappedValue: CryptoViewModel(selectionManager: selectionManager))
        _selectionManager = StateObject(wrappedValue: selectionManager)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Pionex Trading Bot")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Button(action: {
                    showSelectionView = true
                }) {
                    Text("🔍 Sélectionner des cryptos")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                if !viewModel.selectedCryptos.isEmpty {
                    Text("📊 Cryptos sélectionnées")
                        .font(.headline)
                        .padding()
                    
                    List(viewModel.selectedCryptos) { crypto in
                        CryptoRow(crypto: crypto)
                    }
                } else {
                    Text("Aucune crypto sélectionnée. Cliquez sur le bouton pour en ajouter.")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .onAppear {
                viewModel.loadSelectedCryptos()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Marché Crypto").font(.headline)
                }
            }
            .sheet(isPresented: $showSelectionView, onDismiss: {
                viewModel.loadSelectedCryptos()
            }) {
                CryptoSelectionView(selectionManager: selectionManager)
            }
        }
    }
}

struct CryptoRow: View {
    let crypto: CryptoModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(crypto.name)
                    .font(.headline)
                Text(crypto.symbol.uppercased())
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(String(format: "$%.2f", crypto.price))
                .bold()
        }
        .padding()
    }
}
