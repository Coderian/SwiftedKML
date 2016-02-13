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
    case CLAMPTOGROUND, RELATIVETOGROUND, ABSOLUTE
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
public class AltitudeMode : AltitudeModeGroup, HasXMLElementSimpleValue {
    public var description:String {
        get {
            return self.value.rawValue
        }
    }
    public static var elementName: String = "altitudeMode"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? AltitudeMode {
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
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: AltitudeModeEnumType = .CLAMPTOGROUND
    public func makeRelation(contents : String, parent: HasXMLElementName) -> HasXMLElementName {
        self.value = AltitudeModeEnumType(rawValue: contents.uppercaseString)!
        self.parent = parent
        return parent
    }
}
