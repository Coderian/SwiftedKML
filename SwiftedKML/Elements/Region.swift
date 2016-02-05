//
//  Region.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Region
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Region" type="kml:RegionType" substitutionGroup="kml:AbstractObjectGroup"/>
public class Region : AbstractObjectGroup, HasXMLElementValue {
    public static var elementName: String = "Region"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Region {
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
            case let v as NetworkLink:  v.value.region = self
            case let v as Placemark:    v.value.region = self
            case let v as Document:     v.value.region = self
            case let v as Folder :      v.value.region = self
            case let v as GroundOverlay:v.value.region = self
            case let v as PhotoOverlay: v.value.region = self
            case let v as ScreenOverlay:v.value.region = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value : RegionType
    public init(attributes:[String:String]){
        self.value = RegionType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
/// KML RegionType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="RegionType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:LatLonAltBox" minOccurs="0"/>
///     <element ref="kml:Lod" minOccurs="0"/>
///     <element ref="kml:RegionSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:RegionObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="RegionSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="RegionObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class RegionType: AbstractObjectType {
    public var latLonAltBox: LatLonAltBox?
    public var lod : Lod?
    public var regionSimpleExtensionGroup: [AnyObject] = []
    public var regionObjectExtensionGroup: [AbstractObjectGroup] = []
}
