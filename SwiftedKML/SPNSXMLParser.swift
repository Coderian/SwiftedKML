//
//  SPNSXMLParser.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/04.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// Generic Parser of NSXMLParser
public class SPXMLParser<T:HasXMLElementValue where T:XMLElementRoot>: NSObject,NSXMLParserDelegate{
    var parser:NSXMLParser!
    /// 作成中 Elementを保持
    private var stack:Stack<SPXMLElement> = Stack()
    /// 処理しなかったelements
    public var unSupported:Stack<UnSupportXMLElement> = Stack()
    private var contents:String = ""
    private var previewStackCount:Int = 0
    /// parse結果取得用
    var root:T!
    /// root Element Type
    var rootType:T.Type
    var debugPrintOn:Bool = false

    init(Url:NSURL, root:T.Type,debugPrintOn:Bool = false) {
        self.debugPrintOn = debugPrintOn
        parser = NSXMLParser(contentsOfURL: Url)
        self.rootType = root
        super.init()
        parser.delegate = self
    }
    
    func parse() -> T?{
        parser.parse()
        return self.root
    }
    
    internal func createXMLElement(stack:Stack<SPXMLElement>, elementName:String,attributes:[String:String]) -> SPXMLElement {
        guard let retValue = self.rootType.createElement(elementName, attributes: attributes, stack: stack) else {
            // elementが対象外
            return UnSupportXMLElement(elementName: elementName,attributes: attributes)
        }
        return retValue
    }
    
    // MARK: NSXMLParserDelegate
    
    public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        let element = createXMLElement(stack,elementName: elementName,attributes: attributeDict)
        stack.push(element)
        if self.debugPrintOn {
            debugPrint("OnStart didStartElement=\(elementName) pushd=\(element) namespaceURI=\(namespaceURI) qualifiedName=\(qName)")
        }
        self.contents = ""
    }
    
    public func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        let current = stack.pop()
        if self.debugPrintOn {
            debugPrint("OnEnd poped=\(current) == \(elementName)")
        }
        switch current {
        case let element as UnSupportXMLElement:
            if element.elementName == elementName {
                unSupported.push(element)
            }
        case let element as HasXMLElementName:
            if element.dynamicType.elementName == elementName {
                if self.rootType.elementName == elementName {
                    self.root = element as? T
                }
                else {
                    // let parent = stack.pop()
                    let parent = stack.items[stack.count-1]
                    // make the Relationship
                    current.parent = parent
                    // stack.push(parent)
                }
            }
            else {
                stack.push(current)
            }
        default: break
        }
    }
    
    public func parser(parser: NSXMLParser, foundCharacters string: String) {
        // contentsが長い文字列の場合は複数回呼ばれるので対応が必要
        if self.previewStackCount == stack.count {
            self.contents += string
        }
        else{
            self.contents = string
        }
        self.previewStackCount = stack.count
        
        let current = stack.items[stack.count-1]
        if self.debugPrintOn {
            debugPrint("OnCharacters [\(string)] poped=\(current) contents=\(self.contents)")
        }
        if let v = current as? HasXMLElementSimpleValue {
            // stack.push(v.makeRelation( self.contents, parent: stack.pop()))
            v.makeRelation( self.contents, parent: stack.items[stack.count-2])
        } else if let v  = current as? UnSupportXMLElement{
            v.value = self.contents
        }
        // stack.push(current)
        if self.debugPrintOn {
            debugPrint(stack)
        }
    }
}