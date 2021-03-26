//
//  Element.swift - DOM要素オブジェクト
//  
//
//  Created by EnchantCode on 2021/03/26.
//

import Foundation

class Element: Node{
    private (set) public var uuid: NSUUID = NSUUID()
    var tagName: String
    var attributes: [String: String]
    
    var parent: Node?
    var children: [Node]
    public var description: String {
        get{
            let representedAttributes: String
            if self.attributes.keys.count > 0{
                representedAttributes = " " + attributes.map({"\($0.key)=\"\($0.value)\""}).joined(separator:" ")
            }else{
                representedAttributes = ""
            }
            let representedChildren = self.children.map({$0.description}).joined()
            let representedElement = "<\(self.tagName)\(representedAttributes)>\(representedChildren)</\(self.tagName)>"
            return representedElement
        }
    }
        
    init(tagName: String, attributes: [String: String] = [:], children:[Node] = [], parent: Node? = nil){
        
        self.uuid = NSUUID()
        
        self.tagName = tagName
        self.attributes = attributes
        self.children = children
        self.parent = parent
    }
}
