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
        let dynamic = Dynamic(data)
        let styledText =  Dynamic(dynamic[dynamicMember: ".0"]?.value ?? data)
        guard let storage = styledText.storage?.value(as: NSAttributedString.self) else {
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
                
                result.append([
                    "section": "\(Section.text.rawValue)\(partCount)",
                    "title": "Font Line Height",
                    "value": font.lineHeight,
                    "valueType": "number",
                ])
            }
            
            if let paragraph = attributes[.paragraphStyle] as? NSParagraphStyle {
                result.append([
                    "section": "\(Section.text.rawValue)\(partCount)",
                    "title": "Line Height",
                    "value": max(paragraph.minimumLineHeight, paragraph.maximumLineHeight),
                    "valueType": "number",
                ])
                
                result.append([
                    "section": "\(Section.text.rawValue)\(partCount)",
                    "title": "Line Height Multiple",
                    "value": paragraph.lineHeightMultiple,
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
