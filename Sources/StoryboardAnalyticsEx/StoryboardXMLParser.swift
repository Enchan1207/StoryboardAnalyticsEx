//
//  StoryboardXMLParser.swift
//  
//
//  Created by EnchantCode on 2021/03/25.
//

import Foundation

class StoryboardXMLParser: NSObject {
    private var parser: XMLParser!
    
    private var currentIndentDepth = 0 // 現在のインデントの深さ
    private var indentRatio = 4 // 1インデントあたりのスペース数
    
    init(data: Data){
        super.init()
        
        self.parser = XMLParser(data: data)
        self.parser.delegate = self
    }
    
    func parse(){
        self.parser.parse()
    }
    
    // 文字列と要素タイプから出力文字列を生成
    func createIndentedString(_ elem: String, type: TypeOfEntity) -> String{
        // インデント計算
        if type == .startelement{
            currentIndentDepth += 1
        }
        if type == .endelement {
            currentIndentDepth -= 1
        }
        let indentSpaces = String(repeating: " ", count: currentIndentDepth * indentRatio)
        
        // タグまたはコメントの場合は文字列を装飾
        switch type {
        case .comment:
            return indentSpaces + "<!--\(elem)-->"
        case .startelement:
            return indentSpaces + "<\(elem)>"
        case .endelement:
            return indentSpaces + "</\(elem)>"
        default:
            return indentSpaces + elem
        }
    }
    
    // 要素の種類
    enum TypeOfEntity {
        case comment
        case characters
        case startelement
        case endelement
    }
    
}

extension StoryboardXMLParser: XMLParserDelegate {
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("parser start")
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("parser end")
    }
    
    func parser(_ parser: XMLParser, foundComment comment: String) {
        print(createIndentedString(comment, type: .comment))
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let string = string.replacingOccurrences(of: "\n", with: "")
        print(createIndentedString(string, type: .characters))
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // attributeDictを文字列に変換
//        let attributesString = attributeDict.map({"\($0.key)=\"\($0.value)\""}).joined(separator: " ")
        
        print(createIndentedString(elementName, type: .startelement))
//        print("<\(elementName) \(attributesString)>")
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print(createIndentedString(elementName, type: .endelement))
//        print("</\(elementName)>")
    }
    
}
