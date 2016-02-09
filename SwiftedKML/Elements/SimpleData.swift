//
//  SimpleData.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML SimpleData
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="SimpleData" type="kml:SimpleDataType"/>
public class SimpleData : HasXMLElementValue {
    public static var elementName: String = "SimpleData"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? SimpleData {
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
            case let v as SchemaData: v.value.simpleData.append(self)
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value : SimpleDataType
    public init(attributes:[String:String]){
        self.value = SimpleDataType(attributes: attributes)
    }
}
/// KML SimpleDataType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="SimpleDataType" final="#all">
///     <simpleContent>
///     <extension base="string">
///     <attribute name="name" type="string" use="required"/>
///     </extension>
///     </simpleContent>
///     </complexType>
public class SimpleDataType {
    public struct Name: XMLAttributed {
        public static var attributeName:String = "name"
        public var value: String = ""
    }
    public var name : Name = Name()
    init(attributes:[String:String]){
        self.name = Name(value: attributes[Name.attributeName]!)
    }
}
