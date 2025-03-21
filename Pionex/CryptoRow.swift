import SwiftUI

struct CryptoRow: View {
    let crypto: Crypto
    let isFavorite: Bool
    let toggleFavorite: () -> Void

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: crypto.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(crypto.name)
                    .font(.headline)
                Text(crypto.symbol.uppercased())
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Variation : \(crypto.price_change_percentage_24h, specifier: "%.2f")%")
                    .font(.subheadline)
                    .foregroundColor(crypto.price_change_percentage_24h >= 0 ? .green : .red)
            }
            Spacer()
            Text("\(crypto.current_price, specifier: "%.2f") €")
                .font(.headline)
            Button(action: toggleFavorite) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
        }
    }
}

