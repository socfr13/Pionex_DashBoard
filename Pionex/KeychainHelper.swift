import Foundation
import Security

final class KeychainHelper {
    static let shared = KeychainHelper()
    
    private init() {}

    func saveKey(_ key: String, label: String) {
        print("🔵 Tentative de sauvegarde de la clé pour \(label)...")

        let data = key.data(using: .utf8) ?? Data()
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: label,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]

        // Vérifie si la clé existe déjà
        var existingItem: AnyObject?
        let statusCheck = SecItemCopyMatching(query as CFDictionary, &existingItem)
        
        if statusCheck == errSecSuccess {
            // La clé existe déjà, on la met à jour au lieu de la supprimer et recréer
            let updateQuery: [String: Any] = [kSecValueData as String: data]
            let statusUpdate = SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
            
            if statusUpdate == errSecSuccess {
                print("🟢 Mise à jour de la clé existante réussie - Code: \(statusUpdate)")
            } else {
                print("🔴 ERREUR: Échec de la mise à jour de la clé (Code: \(statusUpdate))")
            }
            return
        } else if statusCheck != errSecItemNotFound {
            print("🔴 ERREUR: Échec de la vérification de l'existence de la clé (Code: \(statusCheck))")
        }

        // Ajout de la clé si elle n'existe pas
        let statusAdd = SecItemAdd(query as CFDictionary, nil)
        if statusAdd == errSecSuccess {
            print("🟢 Clé sauvegardée avec succès.")
        } else {
            print("🔴 ERREUR: Impossible d'enregistrer la clé API (Code: \(statusAdd))")
        }
    }

    func getKey(label: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: label,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            switch status {
            case errSecItemNotFound:
                print("🟡 INFO: Aucune clé trouvée pour \(label).")
            case errSecAuthFailed:
                print("🔴 ERREUR: Authentification au Keychain échouée.")
            default:
                print("🔴 ERREUR: Impossible de récupérer la clé API (Code: \(status))")
            }
            return nil
        }
    }
}
