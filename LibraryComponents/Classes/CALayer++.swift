//
//  CALayer++.swift
//  LookinSwiftUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 27/09/24.
//

import UIKit

extension CALayer {
    /// 实现该方法以在 Lookin 中展示自定义属性
    /// 请留意该方法是否已经被父类、子类、分类实现了，如果是，为了避免冲突，你可以把该方法更名为 lookin_customDebugInfos_0（末尾的数字 0 可以被替换为 0 ～ 5 中的任意数字）
    /// 每次 Lookin 刷新时都会调用该方法，因此若该方法耗时较长，则会拖慢刷新速度
    ///
    /// Implement this method to display custom properties in Lookin.
    /// Please note if this method has already been implemented by the superclass, subclass, or category. If so, to avoid conflicts, you can rename this method to lookin_customDebugInfos_0 (the trailing number 0 can be replaced with any number from 0 to 5).
    /// This method is called every time Lookin refreshes, so if this method takes a long time to execute, it will slow down the refresh speed.
    ///
    /// https://bytedance.feishu.cn/docx/TRridRXeUoErMTxs94bcnGchnlb
    @objc func lookin_customDebugInfos() -> [String:Any]? {
        guard
            let delegate = self.delegate, String(describing: delegate).contains("_UIHostingView")
        else { return nil}

        var statusProperty: [String:Any] = [
            "section": Section.global.rawValue,
            "title": "Status",
            "valueType": "string"
        ]

        if #available(iOS 14.0, *),  let debug = delegate as? ViewDebug  {
            StateManager.shared.load(for: debug)
            statusProperty["value"] = "Loaded"
        } else {
            statusProperty["value"] = "Unavailable"
        }
        
        var idsProperty: [String:Any] = [
            "section": Section.global.rawValue,
            "title": "identifiers",
            "valueType": "string"
        ]
        
        if #available(iOS 14.0, *) {
           idsProperty["value"] = StateManager.shared.nodes.keys.joined(separator: "|")
        } else {
            idsProperty["value"] = "xx"
        }

        let ret: [String:Any] = [
            "properties": [ statusProperty, idsProperty ],
            "subviews": self.makeCustomSubviews(),
            "title": "SwiftUI-DebugView"
        ]
        return ret
    }
    
    
    func makeCustomSubviews() -> [Any] {
        let subview0: [String:Any] = [
            // 必填项。该元素在 Lookin 中展示的名字。
            // Required. The name of the element displayed in Lookin.
            "title": "Fake Horse Subview",
            // 可选项。该元素在 Lookin 中展示的副标题。
            // Optional. The subtitle of the element displayed in Lookin.
            "subtitle": "GoodMorning",
            // 可选项。如果包含该项目，则 Lookin 会在中间图像区域展示一个线框。这里的 Rect 是相对于当前 Window 的（不是相对于父元素）。
            // Optional. If this item is included, Lookin will display a wireframe in the middle image area. The Rect here is relative to the current Window (not relative to the parent element).
           // "frameInWindow": NSValue.init(cgRect: CGRect(x: 0, y: 0, width: 300, height: 500)),
            // 可选项。这些信息会展示在 Lookin 的右侧面板，字段格式参见上面的 makeCustomProperties 方法
            // Optional. This information will be displayed in the right-hand panel of Lookin, with field formatting as described in the makeCustomProperties method above.
            "properties": [
                ["section":"Animal Info", "title":"Name", "value":"Mary", "valueType":"string"],
                ["section":"Animal Info", "title":"Age", "value":3.2, "valueType":"number"]
            ]
        ]
        
        let subview1: [String:Any] = [
            "title": "Horse ViewModel",
            // 可选项。你可以递归地添加你的虚拟 subview。
            // Optional. You can recursively add your virtual subview.
            "subviews": [
                ["title": "ViewModel1"],
                ["title": "ViewModel2"]
            ]
        ]
        
        return [subview0, subview1]
    }
}

