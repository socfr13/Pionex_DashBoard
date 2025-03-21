//
//  ContentView.swift
//  CryptoShow
//
//  Created by Sylvain on 20/03/2025.
//

import SwiftUI
import Foundation
import Combine

struct ContentView: View {
    @StateObject var viewModel = CryptoPriceViewModel()
    @State var searchText: String = ""
    @FocusState private var isSearchFieldFocused: Bool

    var sortedCryptos: [Crypto] {
        let favoriteIds = viewModel.favorites.map { $0.id }
        let favorites = viewModel.cryptos.filter { favoriteIds.contains($0.id) }
        let nonFavorites = viewModel.cryptos.filter { !favoriteIds.contains($0.id) }
        return favorites + nonFavorites
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .focused($isSearchFieldFocused)
                    .onAppear {
                        isSearchFieldFocused = true
                    }
                
                if viewModel.isLoading {
                    ProgressView("Chargement des données...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(sortedCryptos) { crypto in
                        CryptoRow(
                            crypto: crypto,
                            isFavorite: viewModel.favorites.contains(where: { $0.id == crypto.id }),
                            toggleFavorite: {
                                viewModel.toggleFavorite(crypto: crypto)
                            }
                        )
                    }
                }
            }
            .navigationTitle("Crypto Dashboard")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        viewModel.loadCryptoPrices()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Menu {
                        Button("Nom") { viewModel.sortOption = .name; viewModel.sortCryptos() }
                        Button("Prix") { viewModel.sortOption = .price; viewModel.sortCryptos() }
                        Button("Capitalisation") { viewModel.sortOption = .marketCap; viewModel.sortCryptos() }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadCryptoPrices()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
