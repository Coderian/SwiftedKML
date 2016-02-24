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
public class SimpleData :SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "SimpleData"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as SchemaData: v.value.simpleData.append(self)
                default: break
                }
            }
        }
    }
    public var value : SimpleDataType
    public required init(attributes:[String:String]){
        self.value = SimpleDataType(attributes: attributes)
        super.init(attributes: attributes)
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
