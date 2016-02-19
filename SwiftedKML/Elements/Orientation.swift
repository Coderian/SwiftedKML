//
//  Orientation.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Orientation
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Orientation" type="kml:OrientationType" substitutionGroup="kml:AbstractObjectGroup"/>
public class Orientation :SPXMLElement, AbstractObjectGroup, HasXMLElementValue {
    public static var elementName: String = "Orientation"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Model: v.value.orientation = self
                default: break
                }
            }
        }
    }
    public var value: OrientationType
    public required init(attributes:[String:String]){
        self.value = OrientationType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public func makeRelation(parent: SPXMLElement) -> SPXMLElement {
        self.parent = parent
        return parent
    }
}
/// KML OrientationType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="OrientationType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:heading" minOccurs="0"/>
///     <element ref="kml:tilt" minOccurs="0"/>
///     <element ref="kml:roll" minOccurs="0"/>
///     <element ref="kml:OrientationSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:OrientationObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="OrientationSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="OrientationObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class OrientationType: AbstractObjectType {
    public var heading: Heading? // = 0.0
    public var tilt: Tilt? // = 0.0
    public var roll: Roll? // = 0.0
    public var orientationSimpleExtensionGroup: [AnyObject] = []
    public var orientationObjectExtensionGroup: [AbstractObjectGroup] = []
}
