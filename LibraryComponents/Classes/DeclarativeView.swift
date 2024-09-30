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
    var prefix = ""
    
    convenience init(from data: SwiftUI._ViewDebug.Data) {
        let values = Dictionary(grouping: Mirror(reflecting: data).children, by: \.label).mapValues{$0.first?.value}
        let properties = values["data"] as?  [SwiftUI._ViewDebug.Property: Any] ?? [:]
//        let childData = values["childData"] as? [SwiftUI._ViewDebug.Data] ?? []
 
//        let subviews = childData.map(DeclarativeView.init(from:))
        self.init(properties, [])
    }
    
    init(_ properties: [SwiftUI._ViewDebug.Property: Any], _ views: [DeclarativeView]) {
        print("+++++DeclarativeView")
        children = views
        className = String(describing: properties[.type]!)
        size = properties[.size] as? CGSize
        if let displayList = properties[.displayList] {
            self.nodes = DeclarativeView.showDisplayList(displayList, prefix: prefix)
        } else {
            self.nodes = []
        }
        
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
        
    }
    var allNodes: [Node] {
        self.nodes + children.map { $0.nodes }.flatMap { $0 }
    }
    
    var nodesByFrame: [String: [Node]] {
        Dictionary(grouping: allNodes) { node in
            (node.frame ?? .zero).debugDescription
        }
    }

    /// Requiere
    ///
    ///   SwiftUI.DisplayList
    internal static func showDisplayList(_ data: Any, prefix: String) -> [Node] {
        let values = Dictionary(grouping: Mirror(reflecting: data).children, by: \.label).mapValues{$0.first?.value}
        guard let items = values["items"] as?  [Any] else { return []}
        return getNodes(from: items, prefix: prefix)
    }
    
    /// SwiftUI.DisplayList.Item
    internal static func getNodes(from items: [Any], prefix: String) -> [Node] {
        var result: [Node] = []
        for item in items {
            let node = Node()
            print("\(prefix) {")
            let properties = Dictionary(grouping: Mirror(reflecting: item).children, by: \.label).compactMapValues{ $0.first?.value }
            
            if let frame = properties["frame"] as? CGRect {
                print("\(prefix)  frame:", frame)
                node.frame = frame
            }
            
            if let value = properties["value"], let content = getContent(for: value, prefix) {
                if let group = content as? GroupContent {
                    result.append(contentsOf: group.nodes)
                    continue
                } else {
                    node.content = content
                }
           
            }
            
            print("\(prefix) }")
            result.append(node)
        }
        return result
    }
    
    
    
    internal static func getContent(for data: Any, _ prefix: String) -> ContentRepresentable? {
        guard let content = Mirror(reflecting: data).children.first?.value else { return nil}
        print("\(prefix)  value:", type(of: content))
//        SwiftUI.DisplayList.Content
        let information = Dictionary(grouping: Mirror(reflecting: content).children, by: \.label).mapValues{$0.first?.value}
        
        print("\(prefix)  keys:", information.keys)
        
        if let value = unwrap_optional(information["value"]) {
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
            
            if let platformView = attributes["platformView"] {
                
            }
        } else if let tupleB =  information[".1"],  let value = unwrap_optional(tupleB) {
            let nodes = getNodes(from: value as? [Any] ?? [], prefix: "\(prefix) \t")
            return GroupContent(nodes: nodes)
        }
        
        return nil
    }
}

