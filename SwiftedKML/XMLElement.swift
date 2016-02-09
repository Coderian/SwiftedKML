//
//  XMLElement.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

public enum RelationshipError : ErrorType {
    case UnmatchParentType(msg:String)
}

/// XML Attribute
public protocol XMLAttributed {
        /// attribute name
        ///
        /// - returns: attribute name
    static var attributeName:String {
        get
    }
    typealias Element
    /// attribute value
    ///
    /// - returns: attribute value
    var value: Element {
        get
        set
    }
}

public extension XMLAttributed {
    /// instance attribute name
    ///
    /// - returns: attribute name
    ///
    public var attributeName:String {
        get {
            return Self.attributeName
        }
    }
}

public protocol HasXMLElementName {
    static var elementName:String {
        get
    }
    var parent:HasXMLElementName? {
        get
        set
    }
    var root:HasXMLElementName { get }
    var childs:[HasXMLElementName] { get set }
    var attributes:[String:String] { get }
}


public protocol HasXMLElementValue :HasXMLElementName, CustomStringConvertible {
    typealias Element
    var value: Element {
        get
        set
    }
}

public protocol HasXMLElementSimpleValue: HasXMLElementValue {
    typealias Element
    var value: Element {
        get
        set
    }
    func makeRelation(contents: String, parent: HasXMLElementName) -> HasXMLElementName
}

public extension HasXMLElementName {
    public var description: String {
        get {
            return Self.elementName
        }
    }
    var root:HasXMLElementName {
        var currentParent:HasXMLElementName = self
        while currentParent.parent != nil {
            currentParent = self.parent!
        }
        return currentParent
    }
    var elementName:String {
        get {
            return Self.elementName
        }
    }
    func select<T:HasXMLElementName>(type:T.Type) -> [T] {
        var ret = [T]()
        for v in self.allChilds().filter({$0 is T}) {
            let t = v as! T
            ret.append(t)
        }
        return ret
    }

/*  実現できてもよさそうだけどできない
    var hasReleation:Bool {
        get {
            // 複数回呼ばれたて同じものがある場合は追加しない
            let selects = self.parent?.select(self.dynamicType)
            // Binary operator '===' cannot be applied to two 'Self' operands
            return selects!.contains({
                $0 === self
            })
        }
    }
*/
    func select(attributeName:String, attributeValue:String) ->[HasXMLElementName] {
        var ret:[HasXMLElementName] = []
        for v in self.allChilds().filter({$0.attributes[attributeName] == attributeValue}){
            ret.append(v)
        }
        return ret
    }
    func allChilds() -> [HasXMLElementName]{
        var all:[HasXMLElementName] = []
        allChilds( &all, current:self)
        return all
    }
    internal func allChilds( inout ret:[HasXMLElementName], current: HasXMLElementName ){
        for child in current.childs {
            allChilds(&ret, current: child)
        }
        ret.append(current)
    }
}
