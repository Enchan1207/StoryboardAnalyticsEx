//
//  StoryboardXMLParser.swift
//  
//
//  Created by EnchantCode on 2021/03/25.
//

import Foundation

class StoryboardXMLParser: NSObject {
    private var parser: XMLParser!
    
    private var rootNode: Node? // ルートノード 全てのノードはこのノードのchildren
    private var currentNode: Node! // 次にappendChildするべきノード
    
    init(data: Data){
        super.init()
        
        self.parser = XMLParser(data: data)
        self.parser.delegate = self
        
        //　初期ノード設定
        self.currentNode = rootNode
    }
    
    func parse(){
        self.parser.parse()
    }
}

extension StoryboardXMLParser: XMLParserDelegate {
    
    func parserDidStartDocument(_ parser: XMLParser) {
        // start of document
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        // end of document (should throw delegate?)
        print(self.rootNode)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // Elementを生成してpushし、currentNodeをずらす
        let newElement = Element(tagName: elementName, attributes: attributeDict)
        self.currentNode?.appendChild(newElement)
        self.currentNode = newElement
        
        if self.rootNode == nil{
            self.rootNode = newElement
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // currentNodeをひとつ戻す
        self.currentNode = self.currentNode.parent
    }
    
    func parser(_ parser: XMLParser, foundComment comment: String) {
        // Textを生成してpush
        let newText = Comment(value: comment)
        self.currentNode?.appendChild(newText)
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // Textを生成してpush
        let newText = Text(value: string)
        self.currentNode?.appendChild(newText)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        // parse error
    }
    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        // validation error
    }
}
