//
//  Data.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Data
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Data" type="kml:DataType" substitutionGroup="kml:AbstractObjectGroup"/>
public class Data : SPXMLElement, AbstractObjectGroup, HasXMLElementValue {
    public static var elementName: String = "Data"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as ExtendedData: v.value.data.append(self)
                default: break
                }
            }
        }
    }

    public var value : DataType
    required public init(attributes:[String:String]){
        self.value = DataType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
/// KML DataType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="DataType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:displayName" minOccurs="0"/>
///     <element ref="kml:value"/>
///     <element ref="kml:DataExtension" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     <attribute name="name" type="string"/>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="DataExtension" abstract="true"/>
public class DataType : AbstractObjectType {
    public var displayName : DisplayName!
    public var value: Value = Value()
    public var dataExtension: [AnyObject] = [] // not supported
    public struct Name : XMLAttributed {
        public static var attributeName:String = "name"
        public var value:String = ""
    }
    public var name: Name = Name()
    public override init(attributes: [String : String]) {
        super.init(attributes: attributes)
        name.value = attributes[Name.attributeName]!
    }
}
