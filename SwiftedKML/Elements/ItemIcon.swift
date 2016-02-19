//
//  ItemIcon.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML ItemIcon
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="ItemIcon" type="kml:ItemIconType" substitutionGroup="kml:AbstractObjectGroup"/>
public class ItemIcon :SPXMLElement, AbstractObjectGroup, HasXMLElementValue {
    public static var elementName: String = "ItemIcon"
    public override var parent:SPXMLElement? {
        didSet {
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as ListStyle: v.value.itemIcon.append(self)
                default: break
                }
            }
        }
    }
    public var value : ItemIconType
    required public init(attributes:[String:String]){
        self.value = ItemIconType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
/// KML ItemIconType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="ItemIconType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:state" minOccurs="0"/>
///     <element ref="kml:href" minOccurs="0"/>
///     <element ref="kml:ItemIconSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:ItemIconObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="ItemIconSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="ItemIconObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class ItemIconType : AbstractObjectType {
    public var state: State?
    public var href: Href?
    public var itemIconSimpleExtensionGroup: [AnyObject] = []
    public var itemIconObjectExtensionGroup: [AbstractObjectGroup] = []
}
