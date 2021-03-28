//
//  ViewConfiguration.swift
//  
//
//  Created by EnchantCode on 2021/03/28.
//

import AppKit
import Foundation

class ViewConfiguration: ComponentConfiguration {
    
    // MARK: - properties
    var contentMode: String
    var translatesAutoresizingMaskIntoConstraints: Bool
    var id: String
    var rect: CGRect
    
    var autoresizingMask: [__AutoResizingMask]?
    var subviews: [ComponentConfiguration]?
    var viewLayoutGuide: [__LayoutGuide]?
    var constraints: [NSLayoutConstraint]?
    
    var viewtype: String
    
    var description: String {
        get{
            let arch: String
            #if os(iOS)
                arch = "UI"
            #else
                arch = "NS"
            #endif
            
            let desc = """
            \(arch)\(viewtype)
                id: \(self.id)
                frame:\(self.rect)
                subviews: \(self.subviews ?? [])
                autoResizingMask: \(self.autoresizingMask?.map({$0.rawValue}).map({AutoResizingMaskKey(value: AutoResizingMaskValue(rawValue: $0)!)}).compactMap({$0}))
                constraints: \(self.constraints ?? [])
            """
            return desc
        }
    }
    
    // MARK: - initializers
    required init?(element: Element) {
        // 必須プロパティが含まれているか?
        let essencialAttributes = ["id", "contentMode"]
        guard essencialAttributes.contains(where: {Array(element.attributes.keys).contains($0)}) else {return nil}
        
        self.id = element.attributes["id"]!
        self.contentMode = element.attributes["contentMode"]!
        self.translatesAutoresizingMaskIntoConstraints = element.attributes["translatesAutoresizingMaskIntoConstraints"] == "YES" ? true: false
        
        // 子要素をチェックし、プロパティに設定
        
        // .viewtype (最初の一文字を大文字にする)
        self.viewtype = element.tagName
            .replacingCharacters(
                in: element.tagName.startIndex...element.tagName.startIndex,
                with: element.tagName.first!.uppercased())
        
        // .rect
        guard let rectElement = element.getElementsBy(tagName: "rect").first else {return nil}
        let rectAttributes = rectElement.attributes.mapValues({Int($0) ?? 0})
        self.rect = CGRect(x: rectAttributes["x"] ?? 0, y: rectAttributes["y"] ?? 0, width: rectAttributes["width"] ?? 0, height: rectAttributes["height"] ?? 0)
        
        // .autoresizingMask
        if let autoresizingMaskElement = element.getElementsBy(tagName: "autoresizingMask").first{
            let autoresizingMasks = autoresizingMaskElement.attributes.keys
                .map({AutoResizingMaskKey(rawValue: $0)})
                .compactMap({$0})
                .map({AutoResizingMaskValue(key: $0)})
                .compactMap({$0})
                .map({__AutoResizingMask(rawValue: $0.rawValue)})
            self.autoresizingMask = autoresizingMasks
        }
        
        // .subviews
        if let subviewNodes = element.getElementsBy(tagName: "subviews").first?.children {
            self.subviews = subviewNodes
                .compactMap({$0 as? Element})
                .map({ViewConfiguration(element: $0)})
                .compactMap({$0})
        }
        
        // .viewLayoutGuide
        if let layoutGuideElements = element.getElementsBy(tagName: "viewLayoutGuide").first{
            // MARK: TODO (objectをdictで登録できるようにしたい)
        }
        
        // .constraints
        if let constraintNodes = element.getElementsBy(tagName: "constraints").first?.children{
            let constraintElements = constraintNodes.compactMap({$0 as? Element})
            
            for constraintElement in constraintElements{
                let essencialAttributes = ["firstItem", "firstAttribute"]
                guard essencialAttributes.contains(where: {Array(constraintElement.attributes.keys).contains($0)}) else {return nil}
                
                // itemをIDで参照できるようにしないとここも解決できない
                //                let constraint = NSLayoutConstraint(
                //                    item: constraintElement.attributes["firstItem"],
                //                    attribute: constraintElement.attributes["firstAttribute"],
                //                    relatedBy: <#T##NSLayoutConstraint.Relation#>,
                //                    toItem: <#T##Any?#>,
                //                    attribute: <#T##NSLayoutConstraint.Attribute#>,
                //                    multiplier: <#T##CGFloat#>,
                //                    constant: <#T##CGFloat#>)
            }
            
            
        }
        
    }
    
}
