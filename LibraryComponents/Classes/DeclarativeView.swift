//
//  AppDelegate.swift
//  Andesrs
//
//
import SwiftUI

class DeclarativeView {
    let className: String
    let size: CGSize?
    let nodes: [Node]
    let children: [DeclarativeView]
    
    convenience init(from data: SwiftUI._ViewDebug.Data) {
        let values = Dictionary(grouping: Mirror(reflecting: data).children, by: \.label).mapValues{$0.first?.value}
        let properties = values["data"] as?  [SwiftUI._ViewDebug.Property: Any] ?? [:]
       // let childData = values["childData"] as? [SwiftUI._ViewDebug.Data] ?? []
       // let subviews = childData.map(DeclarativeView.init(from:))
        self.init(properties, [])
    }
    
    init(_ properties: [SwiftUI._ViewDebug.Property: Any], _ views: [DeclarativeView]) {
        children = views
        className = String(describing: properties[.type]!)
        size = properties[.size] as? CGSize
        if let displayList = properties[.displayList] {
            self.nodes = DeclarativeView.showDisplayList(displayList, prefix: " " )
        } else {
            self.nodes = []
        }
        /*
        print("\(prefix) type:", className)
        print("\(prefix) size:", size)
        print("\(prefix) position:", properties[.position])
        print("\(prefix) value-type:", className)
    
        if String(describing: properties[.type]!) == String(describing: SwiftUI.Text.self) {
            print("\(prefix) value:", properties[.value]!)
        }
        
        if String(describing: properties[.type]!) == "StyledTextContentView" {
            print("\(prefix) value:", properties[.value]!)
        }
        */
    }
    
    var nodesByFrame: [String: [Node]] {
        Dictionary(grouping: nodes) { node in
            (node.frame ?? .zero).debugDescription
        }
    }

    internal static func showDisplayList(_ data: Any,prefix: String) -> [Node] {
        let values = Dictionary(grouping: Mirror(reflecting: data).children, by: \.label).mapValues{$0.first?.value}
        guard let items = values["items"] as?  [Any] else { return []}
        return items.map { item in
            let node = Node()
            print("\(prefix) {")
            let properties = Dictionary(grouping: Mirror(reflecting: item).children, by: \.label).compactMapValues{ $0.first?.value }
            
            if let frame = properties["frame"] as? CGRect {
                print("\(prefix)  frame:", frame)
                node.frame = frame
            }
            
            if let value = properties["value"], let content = getContent(for: value) {
                node.content = content
            }
            print("\(prefix) }")
            return node
        }
    }
    
    internal static func getContent(for data: Any) -> ContentRepresentable? {
        guard let content = Mirror(reflecting: data).children.first?.value else { return nil}
        let information = Dictionary(grouping: Mirror(reflecting: content).children, by: \.label).mapValues{$0.first?.value}
        guard let value = unwrap_optional(information["value"]) else { return nil }
        let attributes = Dictionary(grouping: Mirror(reflecting: value).children, by: \.label).mapValues{$0.first?.value}

        
        print("  attributes:", attributes.keys)
        if let text = attributes["text"], let styledText = unwrap_optional(text) {
            return TextContent(styledText)
        }
        
        if let shape = attributes["shape"] {
            print(" -shape", shape)
        }
        
        if let color = attributes["color"] {
            return ColorContent(color)
        }
        
        return nil
    }
}

