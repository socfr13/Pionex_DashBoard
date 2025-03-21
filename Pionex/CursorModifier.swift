#if os(macOS)
import SwiftUI

extension View {
    func customCursor(_ cursor: NSCursor) -> some View {
        self.onHover { inside in
            if inside {
                cursor.push()
            } else {
                NSCursor.pop()
            }
        }
    }
}
#endif