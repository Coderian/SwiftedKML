//
//  Location.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Location
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Location" type="kml:LocationType" substitutionGroup="kml:AbstractObjectGroup"/>
public class Location :SPXMLElement, AbstractObjectGroup, HasXMLElementValue {
    public static var elementName:String = "Location"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Model: v.value.location = self
                default: break
                }
            }
        }
    }
    public var value : LocationType
    required public init(attributes:[String:String]){
        self.value = LocationType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
/// KML LocationType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="LocationType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:longitude" minOccurs="0"/>
///     <element ref="kml:latitude" minOccurs="0"/>
///     <element ref="kml:altitude" minOccurs="0"/>
///     <element ref="kml:LocationSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:LocationObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="LocationSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="LocationObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class LocationType: AbstractObjectType {
    public var longitude: Longitude? // = 0.0
    public var latitude: Latitude? // = 0.0
    public var altitude: Altitude? // = 0.0
    public var locationSimpleExtensionGroup: [AnyObject] = []
    public var locationObjectExtensionGroup: [AbstractObjectGroup] = []
}
