//
//  ContentRepresentable.swift
//  Andesrs
//
//
import SwiftUI

// SwiftUI.GraphicsImage
class ImageContent: ContentRepresentable {
    var source: String { Section.image.rawValue }

    let orientation: Image.Orientation
    let tint: String
    
    init?(_ data: Any) {
        let dynamic = Dynamic(data)
        orientation = dynamic.orientation?.value(as: Image.Orientation.self) ?? .up
        
        if let maskColor = dynamic.maskColor?.value {
            tint = String(describing: maskColor)
        } else {
            tint =  "#000000FF"
        }
        
    }
    
    var debugInfo: [[String : Any]] {
        let orientation: [String:Any] = [
            "section": source,
            "title": "orientation",
            "value": "\(orientation.rawValue)",
            "valueType": "string",
        ]
        
        let color: [String:Any] = [
            "section": source,
            "title": "Mask Color",
            "value": UIColor(hex: tint),
            "valueType": "color",
        ]
        return [orientation, color]
    }
}
