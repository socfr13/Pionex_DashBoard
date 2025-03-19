import SwiftUI

struct CryptoSelectionView: View {
    @ObservedObject var cryptoListService = CryptoListService()
    @ObservedObject var selectionManager: CryptoSelectionManager
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode

    var filteredCryptos: [CryptoSymbol] {
        if searchText.isEmpty {
            return cryptoListService.availableCryptos
        } else {
            return cryptoListService.availableCryptos.filter { crypto in
                crypto.name.lowercased().contains(searchText.lowercased()) ||
                crypto.symbol.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        VStack {
            Text("Sélectionnez les cryptos à suivre")
                .font(.headline)
                .padding()

            TextField("Rechercher une crypto...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(width: 400)

            if cryptoListService.availableCryptos.isEmpty {
                Text("🔄 Chargement des cryptos...")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(filteredCryptos) { crypto in
                        HStack {
                            Text("\(crypto.name) (\(crypto.symbol.uppercased()))")
                            Spacer()
                            if selectionManager.selectedCryptos.contains(crypto.id) {
                                Button(action: {
                                    selectionManager.selectedCryptos.removeAll { $0 == crypto.id }
                                }) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            } else {
                                Button(action: {
                                    selectionManager.selectedCryptos.append(crypto.id)
                                }) {
                                    Image(systemName: "circle")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("✅ Sauvegarder et afficher le Dashboard")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .frame(minWidth: 600, minHeight: 500)
        .padding()
        .onAppear {
            if cryptoListService.availableCryptos.isEmpty {
                cryptoListService.fetchAvailableCryptos()
            }
        }
    }
}
