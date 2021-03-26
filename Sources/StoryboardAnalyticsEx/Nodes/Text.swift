//
//  Text.swift - テキストオブジェクト
//  
//
//  Created by EnchantCode on 2021/03/26.
//

import Foundation

class Text: Node {
    private (set) public var uuid: NSUUID = NSUUID()
    var tagName: String = "#text"
    var parent: Node?
    var children: [Node] = []
    var value: String
    
    public var description: String {
        get{
            return self.value
        }
    }
    
    init(value: String, parent: Node? = nil){
        self.value = value
        self.parent = parent
    }
}
