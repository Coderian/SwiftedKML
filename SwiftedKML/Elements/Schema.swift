//
//  Schema.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Schema
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Schema" type="kml:SchemaType"/>
public class Schema : HasXMLElementValue {
    public static var elementName: String = "Schema"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Schema {
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
            case let v as Document: v.value.schema.append(self)
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value : SchemaType
    public init(attributes:[String:String]){
        self.value = SchemaType(attributes: attributes)
    }
}
/// KML SchemaType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="SchemaType" final="#all">
///     <sequence>
///     <element ref="kml:SimpleField" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:SchemaExtension" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     <attribute name="name" type="string"/>
///     <attribute name="id" type="ID"/>
///     </complexType>
///     <element name="SchemaExtension" abstract="true"/>
public class SchemaType {
    public var simpleField: [SimpleField] = []
    public var schemaExtension: [AnyObject] = []
    public struct Name: XMLAttributed {
        public static var attributeName:String = "name"
        public var value : String = ""
        init(value:String){
            self.value = value
        }
    }
    public var name: Name?
    public struct ID: XMLAttributed {
        public static var attributeName: String = "id"
        public var value :String = ""
        init(value:String){
            self.value = value
        }
    }
    var id: ID?
    init(attributes:[String:String]){
        self.name = Name(value: attributes[Name.attributeName]!)
        self.id = ID(value: attributes[ID.attributeName]!)
    }
}
