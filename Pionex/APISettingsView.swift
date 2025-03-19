import SwiftUI

struct APISettingsView: View {
    @State private var apiKey: String = KeychainHelper.shared.getKey(label: "PionexAPIKey") ?? ""
    @State private var apiSecret: String = KeychainHelper.shared.getKey(label: "PionexAPISecret") ?? ""
    @State private var showingKey = false
    @State private var showingSecret = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("🔐 Paramètres API")
                .font(.largeTitle)
                .bold()
                .padding()

            VStack(alignment: .leading) {
                Text("Pionex API Key")
                    .font(.headline)
                HStack {
                    if showingKey {
                        TextField("Votre clé API", text: $apiKey)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        SecureField("••••••••••••", text: $apiKey)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Button(action: { showingKey.toggle() }) {
                        Image(systemName: showingKey ? "eye.slash" : "eye")
                            .foregroundColor(.blue)
                    }
                }
            }

            VStack(alignment: .leading) {
                Text("Pionex API Secret")
                    .font(.headline)
                HStack {
                    if showingSecret {
                        TextField("Votre clé secrète", text: $apiSecret)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        SecureField("••••••••••••", text: $apiSecret)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Button(action: { showingSecret.toggle() }) {
                        Image(systemName: showingSecret ? "eye.slash" : "eye")
                            .foregroundColor(.blue)
                    }
                }
            }

            Button(action: {
                KeychainHelper.shared.saveKey(apiKey, label: "PionexAPIKey")
                KeychainHelper.shared.saveKey(apiSecret, label: "PionexAPISecret")
            }) {
                Text("💾 Sauvegarder les clés API")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)

            Spacer()
        }
        .padding()
    }
}
