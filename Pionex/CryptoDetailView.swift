import SwiftUI

struct CryptoDetailView: View {
    let crypto: Crypto

    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: crypto.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())

            Text(crypto.name)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(crypto.symbol.uppercased())
                .font(.title2)
                .foregroundColor(.gray)

            Text("Prix actuel : \(crypto.current_price, specifier: "%.2f") €")
                .font(.headline)

            Text("Capitalisation boursière : \(crypto.market_cap, specifier: "%.0f") €")
                .font(.subheadline)

            Text("Volume total : \(crypto.total_volume, specifier: "%.0f") €")
                .font(.subheadline)

            Text("Variation sur 24h : \(crypto.price_change_percentage_24h, specifier: "%.2f")%")
                .font(.subheadline)
                .foregroundColor(crypto.price_change_percentage_24h >= 0 ? .green : .red)

            Spacer()
        }
        .padding()
        .navigationTitle(crypto.name)
    }
}