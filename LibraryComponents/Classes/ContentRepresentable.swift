//
//  ContentRepresentable.swift
//  Andesrs
//
//
import SwiftUI

enum Section: String {
    case global = "SwiftUI"
    case text = "SwiftUI.Text"
    case color = "SwiftUI.Color"
}


protocol ContentRepresentable {
    var source: String { get }
    var debugInfo: [[String:Any]] { get }
}
