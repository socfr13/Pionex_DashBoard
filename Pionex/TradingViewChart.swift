import SwiftUI
import WebKit

struct TradingViewChart: NSViewRepresentable {
    let symbol: String

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        // 🔥 Correction : Conversion du symbole pour TradingView
        let tradingViewSymbol = convertToTradingViewSymbol(symbol)

        let urlString = "https://www.tradingview.com/chart/?symbol=BINANCE:\(tradingViewSymbol)"
        guard let url = URL(string: urlString) else {
            print("❌ [ERREUR] URL invalide")
            return WKWebView()
        }
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateNSView(_ webView: WKWebView, context: Context) {}

    /// 🔥 Fonction pour convertir les symboles en format TradingView
    func convertToTradingViewSymbol(_ symbol: String) -> String {
        let conversions: [String: String] = [
            "bitcoin": "BTCUSDT",
            "ethereum": "ETHUSDT",
            "binancecoin": "BNBUSDT",
            "cardano": "ADAUSDT"
        ]
        return conversions[symbol.lowercased()] ?? symbol.uppercased() + "USDT"
    }
}
