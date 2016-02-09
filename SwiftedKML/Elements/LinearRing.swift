//
//  LinearRing.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML LinearRing
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="LinearRing" type="kml:LinearRingType" substitutionGroup="kml:AbstractGeometryGroup"/>
public class LinearRing : AbstractGeometryGroup, HasXMLElementValue {
    public static var elementName : String = "LinearRing"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? LinearRing {
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
            case let v as OuterBoundaryIs:  v.value.linearRing = self
            case let v as InnerBoundaryIs:  v.value.linearRing = self
            case let v as MultiGeometry:    v.value.abstractGeometryGroup.append(self)
            case let v as Placemark:        v.value.abstractGeometryGroup = self
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
    public var value : LinearRingType
    init(attributes:[String:String]){
        self.value = LinearRingType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractGeometry : AbstractGeometryType { return self.value }
}
/// KML LinearRingType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="LinearRingType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractGeometryType">
///     <sequence>
///     <element ref="kml:extrude" minOccurs="0"/>
///     <element ref="kml:tessellate" minOccurs="0"/>
///     <element ref="kml:altitudeModeGroup" minOccurs="0"/>
///     <element ref="kml:coordinates" minOccurs="0"/>
///     <element ref="kml:LinearRingSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:LinearRingObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="LinearRingSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="LinearRingObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class LinearRingType: AbstractGeometryType {
    public var extrude : Extrude? // = false
    public var tessellate : Tessellate? // = false
    public var altitudeModeGroup : AltitudeModeGroup?
    public var coordinates : Coordinates?
    public var linearRingSimpleExtensionGroup : [AnyObject] = []
    public var linearRingObjectExtensionGroup : [AbstractObjectGroup] = []
}
