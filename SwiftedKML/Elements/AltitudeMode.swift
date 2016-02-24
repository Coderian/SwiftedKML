//
//  AltitudeMode.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML AltitudeModeEnumType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <simpleType name="altitudeModeEnumType">
///     <restriction base="string">
///     <enumeration value="clampToGround"/>
///     <enumeration value="relativeToGround"/>
///     <enumeration value="absolute"/>
///     </restriction>
///     </simpleType>
public enum AltitudeModeEnumType : String {
    case ClampToGround="clampToGround", RelativeToGround="relativeToGround", Absolute="absolute"
}

/// KML AltitudeModeGroup
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="altitudeModeGroup" abstract="true"/>
public protocol AltitudeModeGroup : CustomStringConvertible {}
/// KML AltitudeMode
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="altitudeMode" type="kml:altitudeModeEnumType" default="clampToGround" substitutionGroup="kml:altitudeModeGroup"/>
public class AltitudeMode : SPXMLElement, HasXMLElementValue, AltitudeModeGroup, HasXMLElementSimpleValue {
    public var description:String {
        get {
            return self.value.rawValue
        }
    }
    public static var elementName: String = "altitudeMode"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch self.parent {
                case let v as Camera:       v.value.altitudeModeGroup = self
                case let v as LatLonAltBox: v.value.altitudeModeGroup = self
                case let v as LinearRing:   v.value.altitudeModeGroup = self
                case let v as LineString:   v.value.altitudeModeGroup = self
                case let v as LookAt:       v.value.altitudeModeGroup = self
                case let v as Model:        v.value.altitudeModeGroup = self
                case let v as Point:        v.value.altitudeModeGroup = self
                case let v as Polygon:      v.value.altitudeModeGroup = self
                default: break
                }
            }
        }
    }
    public var value: AltitudeModeEnumType = .ClampToGround
    public func makeRelation(contents : String, parent: SPXMLElement) -> SPXMLElement {
        self.value = AltitudeModeEnumType(rawValue: contents)!
        self.parent = parent
        return parent
    }
}
