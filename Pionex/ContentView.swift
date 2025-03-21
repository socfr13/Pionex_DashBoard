//
//  ContentView.swift
//  CryptoShow
//
//  Created by Sylvain on 20/03/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = BitcoinPriceViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Cours du Bitcoin (BTC)")
                    .font(.title)
                    .padding()

                if let price = viewModel.price {
                    Text("\(price, specifier: "%.2f") €")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Erreur: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    Text("Chargement du prix...")
                        .padding()
                }
            }
            .onAppear {
                viewModel.fetchBTCPrice()
            }
            .navigationTitle("Crypto Show")

            // --------------------------------------------------
            // IMPLEMENTATION CORRECTE DE LA TOOLBAR POUR macOS: Utilisation de .toolbar et placement .automatic
            // AUCUNE UTILISATION DE .navigationBarTrailing ICI
            .toolbar { // Utiliser le modificateur .toolbar pour la barre d'outils macOS
                ToolbarItem(placement: .automatic) { // Placement AUTOMATIQUE dans la toolbar macOS
                    Button("Actualiser") {
                        viewModel.fetchBTCPrice()
                    }
                }
            }
            // --------------------------------------------------
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
