//
//  Item.swift
//  Pionex
//
//  Created by Sylvain Otparlic on 18/03/2025.
//

import Foundation
import SwiftData

@available(macOS 14, *)
@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
