//
//  Polygon.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation
import MapKit

/// KML Polygon
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Polygon" type="kml:PolygonType" substitutionGroup="kml:AbstractGeometryGroup"/>
public class Polygon : AbstractGeometryGroup, HasXMLElementValue {
    public static var elementName: String = "Polygon"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Polygon {
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
            case let v as MultiGeometry:v.value.abstractGeometryGroup.append(self)
            case let v as Placemark:    v.value.abstractGeometryGroup = self
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
    public var value : PolygonType
    public init(attributes:[String:String]){
        self.value = PolygonType(attributes: attributes)
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
    public var extrude: Extrude? // = false
    public var tessellate: Tessellate? // = false
    public var altitudeModeGroup: AltitudeModeGroup?
    public var outerBoundaryIs: OuterBoundaryIs?
    public var innerBoundaryIs: InnerBoundaryIs?
    public var polygonSimpleExtensionGroup: [AnyObject] = []
    public var polygonObjectExtensionGroup: [AbstractObjectGroup] = []
}

extension Polygon {
    var polygon:MKPolygon {
        var coords = self.value.outerBoundaryIs!.value.linearRing!.value.coordinates!.locationCoordinates
        var polygons:[MKPolygon] = []
        if var innerBoundaryIsCoord:[CLLocationCoordinate2D] = self.value.innerBoundaryIs?.value.linearRing?.value.coordinates?.locationCoordinates {
            polygons.append(MKPolygon(coordinates: &innerBoundaryIsCoord, count: innerBoundaryIsCoord.count))
        }
        
        return MKPolygon(coordinates: &coords, count: coords.count, interiorPolygons: polygons)
    }
}