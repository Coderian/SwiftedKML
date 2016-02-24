//
//  ResourceMap.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML ResourceMap
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="ResourceMap" type="kml:ResourceMapType" substitutionGroup="kml:AbstractObjectGroup"/>
public class ResourceMap :SPXMLElement, AbstractObjectGroup, HasXMLElementValue {
    public static var elementName: String = "ResourceMap"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as Model: v.value.resourceMap = self
                default: break
                }
            }
        }
    }
    public var value : ResourceMapType
    public required init(attributes:[String:String]){
        self.value = ResourceMapType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
/// KML ResourceMapType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="ResourceMapType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:Alias" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:ResourceMapSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:ResourceMapObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="ResourceMapSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="ResourceMapObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class ResourceMapType: AbstractObjectType {
    public var alias: [Alias] = []
    public var resourceMapSimpleExtensionGroup: [AnyObject] = []
    public var resourceMapObjectExtensionGroup: [AbstractObjectGroup] = []
}
