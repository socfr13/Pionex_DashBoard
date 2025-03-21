import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Rechercher...", text: $text)
                .padding(7)
                .background(Color(NSColor.windowBackgroundColor)) // Correction ici
                .cornerRadius(8)
                .padding(.horizontal, 10)
        }
    }
}