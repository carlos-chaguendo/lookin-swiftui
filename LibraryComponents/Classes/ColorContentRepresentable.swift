//
//  ContentRepresentable.swift
//  Andesrs
//
//
import SwiftUI

// SwiftUI.Color.Resolved
class ColorContent: ContentRepresentable {
    var source: String { Section.color.rawValue }
    let hex: String
    
    init?(_ data: Any) {
        hex = String(describing: data).replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "")
    }
    
    var debugInfo: [[String : Any]] {
        let colorHex: [String:Any] = [
            "section": source,
            "title": "hex",
            "value": hex,
            "valueType": "string",
        ]
        
        let color: [String:Any] = [
            "section": source,
            "title": "color",
            "value": UIColor(hex: hex),
            "valueType": "color",
        ]
        return [colorHex, color]
    }
}

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }

    /// init UIColor with hex code
    /// - Parameter hex: color representation, e.g: "#FFFFFF" or with alpha "#FF000000"
    convenience init?(hex: String) {
        var cString: String = hex.uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue: UInt64 = 0
        guard (cString.count == 6 || cString.count == 8) &&
            Scanner(string: cString).scanHexInt64(&rgbValue) else {
            return nil
        }
        if cString.count == 6 {
            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        } else {
            self.init(
                red: CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x000000FF) / 255.0,
                alpha: CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
            )
        }
    }
}

