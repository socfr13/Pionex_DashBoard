//
//  ContentView.swift
//  CryptoShow
//
//  Created by Sylvain on 20/03/2025.
//
/* Mise à jour de GitHub
git add .
git commit -m "Correction des erreurs Xcode : problème Preview Content et gestion DecodingError"
git push origin main
*/

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = BitcoinPriceViewModel()

    var body: some View {
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

            Button("Actualiser le prix") {
                viewModel.fetchBTCPrice()
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchBTCPrice()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
