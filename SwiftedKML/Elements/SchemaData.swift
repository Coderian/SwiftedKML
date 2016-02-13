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
public class SchemaData : AbstractObjectGroup, HasXMLElementValue {
    public static var elementName: String = "SchemaData"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? SchemaData {
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
            case let v as ExtendedData: v.value.schemaData.append(self)
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String]{
        var attributes:[String:String] = [:]
        if let attr = self.value.attribute {
            attributes[attr.id.dynamicType.attributeName] = attr.id.value
            attributes[attr.targetId.dynamicType.attributeName] = attr.targetId.value
        }
        return attributes
    }
    public var value : SchemaDataType
    public init(attributes:[String:String]){
        self.value = SchemaDataType(attributes: attributes)
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
        public var value: String? // TODO: #globalIconなどの自己参照があるので要検討
    }
    public var schemaUrl: SchemaUrl?
}
