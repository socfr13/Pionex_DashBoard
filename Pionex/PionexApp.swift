//
//  PionexApp.swift
//  Pionex
//
//  Created by Sylvain Otparlic on 18/03/2025.
//

import SwiftUI
import SwiftData

@main
struct PionexApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack {
                    ContentView()
                    NavigationLink("Paramètres API", destination: SettingsView())
                        .padding()
                }
            }
        }
    }
}
