//
//  AppDelegate.swift
//  Andesrs
//
//
import SwiftUI

@dynamicMemberLookup
class Dynamic: CustomDebugStringConvertible {

    let mirror:Mirror
    let properties: [String: Any?]
    let value: Any
    
    public init(_ object: Any) {
        let mirror = Mirror(reflecting: object)
        self.properties = Dictionary(grouping: mirror.children, by: { $0.label ?? "unknow"}).compactMapValues{ $0.first!.value }
        self.value = object
        self.mirror = mirror
    }
    
    public subscript(dynamicMember member: String) -> Dynamic? {
        if let item = properties[member], let value = item {
            if let option = value as? Optional<Any> {
                switch option {
                case .none: return nil
                case .some(let value):
                    return  Dynamic(value)
                }
            }
            return Dynamic(value)
        }
        return nil
    }
    
    func value<Value>(as: Value.Type) -> Value? {
        value as? Value
    }
    
    func value<Value>(as: Value.Type, default: Value) -> Value {
        value as? Value ?? `default`
    }
    
    func tree(_ prefix:String = "\t", visited: Set<String> = []) {
        for (property, data) in properties {
            print("\(prefix)\(property)", terminator: ":")
            if let data {
                
                print(type(of: data))
//                let dynamic =  Dynamic(data)
//                if visited.contains(dynamic.id) {
//                    continue
//                }
//                
//                var items = visited
//                items.insert(self.id)
                Dynamic(data).tree("\(prefix)\t", visited: [])
            } else {
                print("nil")
            }
        }
    }
    
    var debugDescription: String {
        """
        type:\(type(of: value))
        properties:\(Array(properties.keys))
        value: \(value)
        """
    }
}
