//
//  AppDelegate.swift
//  Andesrs
//
//
import SwiftUI

@available(iOS 14.0, *)
class StateManager {
    static var shared = StateManager()
    
    var isLoaded: Bool = false
    var nodes: [String: [Node]] = [:]
    
    func load(for debug: ViewDebug) {
        let view = debug._viewDebugData().map(DeclarativeView.init(from:))
        
        nodes = view.map { $0.nodesByFrame }.reduce([:], { current, next in
            current.merge(dict: next)
        })
        
        isLoaded = true
    }
}

extension Dictionary {
    func merge(dict: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
        var mutableCopy = self
        for (key, value) in dict {
            // If both dictionaries have a value for same key, the value of the other dictionary is used.
            mutableCopy[key] = value
        }
        return mutableCopy
    }
}
