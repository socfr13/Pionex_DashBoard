# Pionex Dashboard

Pionex Dashboard est une application SwiftUI permettant de suivre les prix des cryptomonnaies en temps réel. Elle offre des fonctionnalités telles que la recherche, le tri, et la gestion des favoris.

## Fonctionnalités

- **Affichage des prix des cryptomonnaies** : Consultez les prix actuels des cryptomonnaies.
- **Recherche** : Recherchez des cryptomonnaies spécifiques grâce à une barre de recherche.
- **Tri** : Triez les cryptomonnaies par nom, prix ou capitalisation.
- **Favoris** : Ajoutez ou supprimez des cryptomonnaies de votre liste de favoris.
- **Actualisation** : Rechargez les données en temps réel.

## Structure du Projet
Collecting workspace informationVoici un exemple de fichier README.md pour votre projet :

```markdown
# Pionex Dashboard

Pionex Dashboard est une application SwiftUI permettant de suivre les prix des cryptomonnaies en temps réel. Elle offre des fonctionnalités telles que la recherche, le tri, et la gestion des favoris.

## Fonctionnalités

- **Affichage des prix des cryptomonnaies** : Consultez les prix actuels des cryptomonnaies.
- **Recherche** : Recherchez des cryptomonnaies spécifiques grâce à une barre de recherche.
- **Tri** : Triez les cryptomonnaies par nom, prix ou capitalisation.
- **Favoris** : Ajoutez ou supprimez des cryptomonnaies de votre liste de favoris.
- **Actualisation** : Rechargez les données en temps réel.

## Structure du Projet

```
Pionex_DashBoard/
├── Pionex/
│   ├── APISettingsView.swift
│   ├── BitcoinPriceViewModel.swift
│   ├── BTCPriceModel.swift
│   ├── ContentView.swift
│   ├── Crypto.swift
│   ├── CryptoDetailView.swift
│   ├── CryptoListService.swift
│   ├── CryptoPriceViewModel.swift
│   ├── CryptoRow.swift
│   └── ...
├── PionexTests/
├── PionexUITests/
├── Package.swift
├── README.md
└── .vscode/
```

## Prérequis

- **macOS 12 ou supérieur** (macOS 14 recommandé pour certaines fonctionnalités avancées).
- **Xcode 14 ou supérieur**.
- **Swift 5.7 ou supérieur**.

## Installation

1. Clonez ce dépôt :
   ```bash
   git clone https://github.com/votre-utilisateur/Pionex_DashBoard.git
   cd Pionex_DashBoard
   ```

2. Ouvrez le projet dans Xcode :
   ```bash
   open Pionex.xcodeproj
   ```

3. Construisez et exécutez le projet.

## Utilisation

- **Recherche** : Utilisez la barre de recherche pour trouver une cryptomonnaie spécifique.
- **Tri** : Cliquez sur l'icône de tri dans la barre d'outils pour trier les cryptomonnaies.
- **Favoris** : Cliquez sur l'icône étoile pour ajouter ou retirer une cryptomonnaie des favoris.
- **Actualisation** : Cliquez sur l'icône de rechargement pour mettre à jour les données.

## Contribution

Les contributions sont les bienvenues ! Veuillez suivre ces étapes :

1. Forkez le projet.
2. Créez une branche pour votre fonctionnalité ou correction de bug :
   ```bash
   git checkout -b feature/nom-de-la-fonctionnalite
   ```
3. Faites vos modifications et validez-les :
   ```bash
   git commit -m "Ajout de la fonctionnalité X"
   ```
4. Poussez vos modifications :
   ```bash
   git push origin feature/nom-de-la-fonctionnalite
   ```
5. Ouvrez une Pull Request.

## Licence

Ce projet est sous licence MIT. Consultez le fichier `LICENSE` pour plus d'informations.
```