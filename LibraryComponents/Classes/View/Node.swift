//
//  AppDelegate.swift
//  Andesrs
//
//
import SwiftUI


class Node {
    var frame: CGRect?
    var content: ContentRepresentable?
    var debugInfo: [[String:Any]] { content?.debugInfo ?? []}
}
