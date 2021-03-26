//
//  Node.swift - DOMの基底インタフェース
//
//
//  Created by EnchantCode on 2021/03/26.
//

import Foundation

protocol Node: CustomStringConvertible {
    var uuid: NSUUID {get}
    
    var tagName: String { get }
    var parent: Node? { get set }
    var children: [Node] { get set }
    var description: String { get }
    
    mutating func appendChild(_ node: Node)
    mutating func removeChild(_ node: Node)
}

extension Node {
    
    mutating func appendChild(_ node: Node){
        var node = node
        node.parent = self
        self.children.append(node)
    }
    
    mutating func removeChild(_ node: Node){
        self.children = self.children.filter({$0.uuid != node.uuid})
    }
}
