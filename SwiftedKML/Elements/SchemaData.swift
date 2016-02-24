//
//  SchemaData.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML SchemaData
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="SchemaData" type="kml:SchemaDataType" substitutionGroup="kml:AbstractObjectGroup"/>
public class SchemaData :SPXMLElement, AbstractObjectGroup, HasXMLElementValue {
    public static var elementName: String = "SchemaData"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as ExtendedData: v.value.schemaData.append(self)
                default: break
                }
            }
        }
    }
    public var value : SchemaDataType
    public required init(attributes:[String:String]){
        self.value = SchemaDataType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
/// KML SchemaDataType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="SchemaDataType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:SimpleData" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:SchemaDataExtension" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     <attribute name="schemaUrl" type="anyURI"/>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="SchemaDataExtension" abstract="true"/>
public class SchemaDataType: AbstractObjectType {
    public var simpleData : [SimpleData] = []
    public var schemaDataExtension: [AnyObject] = []
    public struct SchemaUrl : XMLAttributed {
        public static var attributeName:String = "schemaUrl"
        public var value: String! // TODO: #globalIconなどの自己参照があるので要検討
    }
    public var schemaUrl: SchemaUrl!
}
