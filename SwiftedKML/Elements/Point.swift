//
//  Point.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Point
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Point" type="kml:PointType" substitutionGroup="kml:AbstractGeometryGroup"/>
public class Point :SPXMLElement, AbstractGeometryGroup, HasXMLElementValue {
    public static var elementName: String = "Point"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as PhotoOverlay: v.value.point = self
                case let v as MultiGeometry:v.value.abstractGeometryGroup.append(self)
                case let v as Placemark:    v.value.abstractGeometryGroup = self
                default: break
                }
            }
        }
    }
    public var value : PointType
    required public init(attributes:[String:String]){
        self.value = PointType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractGeometry : AbstractGeometryType { return self.value }
}
/// KML PointType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="PointType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractGeometryType">
///     <sequence>
///     <element ref="kml:extrude" minOccurs="0"/>
///     <element ref="kml:altitudeModeGroup" minOccurs="0"/>
///     <element ref="kml:coordinates" minOccurs="0"/>
///     <element ref="kml:PointSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:PointObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="PointSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="PointObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class PointType: AbstractGeometryType,CustomStringConvertible {
    public var description: String {
        get {
            return (self.coordinates?.value.description)!
        }
    }
    public var extrude: Extrude? // = false
    public var altitudeModeGroup: AltitudeModeGroup?
    public var coordinates: Coordinates?
    public var pointSimpleExtensionGroup: [AnyObject] = []
    public var pointObjectExtensionGroup: [AbstractObjectGroup] = []
}
