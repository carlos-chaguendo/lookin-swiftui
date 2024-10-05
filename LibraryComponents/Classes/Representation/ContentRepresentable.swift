//
//  ContentRepresentable.swift
//  Andesrs
//
//
import SwiftUI

enum Section: String {
    case global = "SwiftUI"
    case text = "SwiftUI.Text"
    case image = "SwiftUI.Image"
    case color = "SwiftUI.Color"
    case group = "SwiftUI.Group"
}


protocol ContentRepresentable {
    var source: String { get }
    var debugInfo: [[String:Any]] { get }
}


class GroupContent: ContentRepresentable {
    var source: String = Section.group.rawValue
    var debugInfo: [[String : Any]] = []
    let nodes: [Node]
    init(nodes: [Node]) {
        self.nodes = nodes
    }
}
