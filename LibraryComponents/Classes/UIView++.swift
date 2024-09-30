//
//  AppDelegate.swift
//  Andesrs
//
//
import SwiftUI


//
//_UIHostingView
public extension UIView {
    
    
    @objc func lookin_customDebugInfos() -> [String:Any]? {
        let ret: [String: Any] = [
            "properties": makeCustomProperties(),
        ]
        return ret
    }
    
    private func makeCustomProperties() -> [Any] {
        guard #available(iOS 14.0, *) else { return []}
    
        var response: [Any] = []
        
//        response.append([
//            "section": Section.global.rawValue,
//            "title": "name",
//            "value": String(describing: type(of: self)),
//            "valueType": "string",
//        ])
//        
//        response.append([
//            "section": Section.global.rawValue,
//            "title": "id",
//            "value": frame.debugDescription,
//            "valueType": "string",
//        ])
        
        if let info = StateManager.shared.nodes[self.frame.debugDescription] {
            // Si tiene mas de un nodo significa que hay mas de un view en la misma position
            if let node = info.first {
                response.append(contentsOf: node.debugInfo)
            }
            
            
            response.append([
                "section": Section.global.rawValue,
                "title": "Source",
                "value": info.map {$0.content?.source ?? "Any"}.joined(separator: "|"),
                "valueType": "string",
            ])
        } else {
//            response.append([
//                "section": Section.global.rawValue,
//                "title": "content",
//                "value": frame.debugDescription,
//                "valueType": "string",
//            ])
        }

        return response
    }
    
    @objc func p() -> [String: Any]? {
        
        if #available(iOS 14.0, *) {
            if let debug = self as? ViewDebug {
                let view = debug
                    ._viewDebugData()
                    .map(DeclarativeView.init(from:))
                print(view)
                
                return [
                    "debug": view.map { $0.nodes.map{ $0.debugInfo} }
                ]
                
            }
        }
        
        
        let ret: [String: Any] = [
            "properties": "",
        ]
        return ret
    }
    
}
