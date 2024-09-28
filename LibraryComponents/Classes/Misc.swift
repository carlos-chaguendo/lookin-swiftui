//
//  AppDelegate.swift
//  Andesrs
//
//
import SwiftUI

func unwrap_optional(_ value: Any) -> Any? {
    let values = Dictionary(grouping: Mirror(reflecting: value).children, by: \.label).mapValues{$0.first?.value}
    guard let some = values["some"] else { return nil }
    guard let content = Mirror(reflecting: values["some"]!!).children.first?.value else { return nil }
    return content
}

func unwrap_optional<Result>(_ value: Any, as: Result.Type) -> Result? {
    return unwrap_optional(value) as? Result
}
