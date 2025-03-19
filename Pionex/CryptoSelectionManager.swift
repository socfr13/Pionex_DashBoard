//
//  CryptoSelectionManager.swift
//  Pionex
//
//  Created by Sylvain Otparlic on 18/03/2025.
//

import Foundation

class CryptoSelectionManager: ObservableObject {
    @Published var selectedCryptos: [String] {
        didSet {
            UserDefaults.standard.set(selectedCryptos, forKey: "selectedCryptos")
        }
    }
    
    init() {
        self.selectedCryptos = UserDefaults.standard.stringArray(forKey: "selectedCryptos") ?? ["bitcoin", "ethereum"]
    
        print("🔍 Sélection enregistrée : \(selectedCryptos)")
        
    }
    
}
