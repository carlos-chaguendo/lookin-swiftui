//
//  ContentRepresentable.swift
//  Andesrs
//
//
import SwiftUI

// SwiftUI.ResolvedStyledText
class TextContent: ContentRepresentable {
    var source: String { Section.text.rawValue }
    let attributedText: NSAttributedString

    init?(_ data: Any) {
        let values = Dictionary(grouping: Mirror(reflecting: data).children, by: \.label).mapValues{$0.first?.value}
        guard let storage = unwrap_optional(values["storage"], as: NSAttributedString.self) else {
            return nil
        }
        self.attributedText = storage
    }

    var debugInfo: [[String : Any]] {
        var result: [[String : Any]] = []
//        result.append([
//            "section": Section.text.rawValue,
//            "title": "all",
//            "value": attributedText.debugDescription,
//            "valueType": "string",
//        ])
        
        
        let range = NSRange(location: 0, length: attributedText.length)
        var partCount = 0

        
        attributedText.enumerateAttributes(in: range) { (attributes, range, stop) in
            partCount += 1
            let text = attributedText.attributedSubstring(from: range).string
            result.append([
                "section": "\(Section.text.rawValue)\(partCount)",
                "title": "Text",
                "value": text,
                "valueType": "string",
            ])
            
            if let font = attributes[.font] as? UIFont {
                result.append([
                    "section": "\(Section.text.rawValue)\(partCount)",
                    "title": "Font Name",
                    "value": font.fontName,
                    "valueType": "string",
                ])
                result.append([
                    "section": "\(Section.text.rawValue)\(partCount)",
                    "title": "Font Size",
                    "value": font.pointSize,
                    "valueType": "number",
                ])
            }
            
            result.append([
                "section": "\(Section.text.rawValue)\(partCount)",
                "title": "Foreground Color",
                "value": attributes[.foregroundColor],
                "valueType": "color",
            ])
        }
        return result
    }
}
