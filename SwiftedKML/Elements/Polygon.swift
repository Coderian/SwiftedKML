//
//  Polygon.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Polygon
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Polygon" type="kml:PolygonType" substitutionGroup="kml:AbstractGeometryGroup"/>
public class Polygon :SPXMLElement, AbstractGeometryGroup, HasXMLElementValue {
    public static var elementName: String = "Polygon"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as MultiGeometry:v.value.abstractGeometryGroup.append(self)
                case let v as Placemark:    v.value.abstractGeometryGroup = self
                default: break
                }
            }
        }
    }
    public var value : PolygonType
    public required init(attributes:[String:String]){
        self.value = PolygonType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractGeometry : AbstractGeometryType { return self.value }
}
/// KML PolygonType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="PolygonType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractGeometryType">
///     <sequence>
///     <element ref="kml:extrude" minOccurs="0"/>
///     <element ref="kml:tessellate" minOccurs="0"/>
///     <element ref="kml:altitudeModeGroup" minOccurs="0"/>
///     <element ref="kml:outerBoundaryIs" minOccurs="0"/>
///     <element ref="kml:innerBoundaryIs" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:PolygonSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:PolygonObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="PolygonSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="PolygonObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class PolygonType: AbstractGeometryType {
    public var extrude: Extrude! // = false
    public var tessellate: Tessellate! // = false
    public var altitudeModeGroup: AltitudeModeGroup!
    public var outerBoundaryIs: OuterBoundaryIs!
    public var innerBoundaryIs: InnerBoundaryIs!
    public var polygonSimpleExtensionGroup: [AnyObject] = []
    public var polygonObjectExtensionGroup: [AbstractObjectGroup] = []
}
