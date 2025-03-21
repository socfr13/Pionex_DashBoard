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

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Chargement des données...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Erreur: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.cryptos, id: \.id) { crypto in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(crypto.name) // Assurez-vous que `name` est de type String
                                    .font(.headline)
                                Text(crypto.symbol.uppercased()) // Assurez-vous que `symbol` est de type String
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("\(crypto.current_price, specifier: "%.2f") €")
                                .font(.headline)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
