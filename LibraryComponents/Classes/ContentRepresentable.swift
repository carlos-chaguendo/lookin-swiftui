//
//  ContentRepresentable.swift
//  Andesrs
//
//
import SwiftUI

protocol ContentRepresentable {}

class TextContent: ContentRepresentable {
    let attributedText: NSAttributedString
    // SwiftUI.ResolvedStyledText
    init?(_ data: Any) {
        let values = Dictionary(grouping: Mirror(reflecting: data).children, by: \.label).mapValues{$0.first?.value}
        guard let storage = unwrap_optional(values["storage"], as: NSAttributedString.self) else {
            return nil
        }
        self.attributedText = storage
    }
}

// SwiftUI.Color.Resolved
class ColorContent: ContentRepresentable {
    let hex: String
    
    init?(_ data: Any) {
        hex = String(describing: data)
    }
}
