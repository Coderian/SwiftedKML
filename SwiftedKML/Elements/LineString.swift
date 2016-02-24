//
//  LineString.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML LineString
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="LineString" type="kml:LineStringType" substitutionGroup="kml:AbstractGeometryGroup"/>
public class LineString :SPXMLElement, AbstractGeometryGroup, HasXMLElementValue {
    public static var elementName:String = "LineString"
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
    public var value : LineStringType
    required public init(attributes:[String:String]){
        self.value = LineStringType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractGeometry : AbstractGeometryType { return self.value }
}
/// KML LineStringType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="LineStringType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractGeometryType">
///     <sequence>
///     <element ref="kml:extrude" minOccurs="0"/>
///     <element ref="kml:tessellate" minOccurs="0"/>
///     <element ref="kml:altitudeModeGroup" minOccurs="0"/>
///     <element ref="kml:coordinates" minOccurs="0"/>
///     <element ref="kml:LineStringSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:LineStringObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="LineStringSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="LineStringObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class LineStringType: AbstractGeometryType {
    public var extrude: Extrude! // = false
    public var tessellate: Tessellate! // = false
    public var altitudeModeGroup : AltitudeModeGroup!
    public var coordinates : Coordinates!
    public var linearRingSimpleExtensionGroup : [AnyObject] = []
    public var linearRingObjectExtensionGroup : [AbstractObjectGroup] = []
}
