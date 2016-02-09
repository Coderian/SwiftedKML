//
//  SimpleField.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML SimpleField
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="SimpleField" type="kml:SimpleFieldType"/>
public class SimpleField : HasXMLElementValue {
    public static var elementName: String = "SimpleFiled"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? SimpleField {
                        return v === self
                    }
                    return false
                })
                self.parent?.childs.removeAtIndex(index!)
            }
        }
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            let selects = self.parent?.select(self.dynamicType)
            if selects!.contains({ $0 === self }) {
                return
            }
            self.parent?.childs.append(self)
            switch parent {
            case let v as Schema: v.value.simpleField.append(self)
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value : SimpleFieldType
    public init(attributes:[String:String]){
        self.value = SimpleFieldType(attributes: attributes)
    }
}
/// KML SimpleFieldType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="SimpleFieldType" final="#all">
///     <sequence>
///     <element ref="kml:displayName" minOccurs="0"/>
///     <element ref="kml:SimpleFieldExtension" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     <attribute name="type" type="string"/>
///     <attribute name="name" type="string"/>
///     </complexType>
///     <element name="SimpleFieldExtension" abstract="true"/>
public class SimpleFieldType {
    public var displayName: DisplayName?
    public var simpleFieldExtension: [SimpleFieldExtension] = []
    public struct Type: XMLAttributed {
        public static var attributeName:String = "type"
        public var value: String = ""
    }
    public var type: Type?
    public struct Name: XMLAttributed {
        public static var attributeName:String = "name"
        public var value : String = ""
    }
    public var name: Name?
    init(attributes:[String:String]){
        self.type = Type(value: attributes[Type.attributeName]!)
        self.name = Name(value: attributes[Name.attributeName]!)
    }
}
/// KML SimpleFieldExtension
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="SimpleFieldExtension" abstract="true"/>
public class SimpleFieldExtension : HasXMLElementValue {
    public static var elementName:String = "SimpleFieldExtension"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? SimpleFieldExtension {
                        return v === self
                    }
                    return false
                })
                self.parent?.childs.removeAtIndex(index!)
            }
        }
        didSet{
            // 複数回呼ばれたて同じものがある場合は追加しない
            let selects = self.parent?.select(self.dynamicType)
            if selects!.contains({ $0 === self }) {
                return
            }
            self.parent?.childs.append(self)
            switch parent {
            case let v as SimpleField: v.value.simpleFieldExtension.append(self)
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value:String=""
}
