//
//  AppDelegate.swift
//  Andesrs
//
//
import SwiftUI

@available(iOS 14.0, *)
protocol ViewDebug {
    func _viewDebugData() -> [SwiftUI._ViewDebug.Data]
    var _rendererObject: Swift.AnyObject? { get}
    var _rendererConfiguration: SwiftUI._RendererConfiguration { get }
    func viewForIdentifier<I, V>(_ identifier: I, _ type: V.Type) -> V? where I : Swift.Hashable, V : SwiftUI.View
}

@available(iOS 14.0, *)
extension SwiftUI._UIHostingView: ViewDebug { }
