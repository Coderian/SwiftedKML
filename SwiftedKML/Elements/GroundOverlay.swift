//
//  GroundOverlay.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML GoundOverlay
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="GroundOverlay" type="kml:GroundOverlayType" substitutionGroup="kml:AbstractOverlayGroup"/>
public class GroundOverlay :SPXMLElement, AbstractOverlayGroup, HasXMLElementValue {
    public static var elementName: String = "GroundOverlay"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Delete:   v.value.abstractFeatureGroup.append(self)
                case let v as Kml:      v.value.abstractFeatureGroup = self
                case let v as Folder:   v.value.abstractFeatureGroup.append(self)
                case let v as Document: v.value.abstractFeatureGroup.append(self)
                default: break
                }
            }
        }
    }
    public var value : GroundOverlayType
    required public init(attributes:[String:String]){
        self.value = GroundOverlayType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractFeature : AbstractFeatureType { return self.value }
    public var abstractOverlay : AbstractOverlayType { return self.value }
}
/// KML GoundOverlayType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="GroundOverlayType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractOverlayType">
///     <sequence>
///     <element ref="kml:altitude" minOccurs="0"/>
///     <element ref="kml:altitudeModeGroup" minOccurs="0"/>
///     <element ref="kml:LatLonBox" minOccurs="0"/>
///     <element ref="kml:GroundOverlaySimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:GroundOverlayObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="GroundOverlaySimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="GroundOverlayObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class GroundOverlayType: AbstractOverlayType {
    public var altitude:Altitude!
    public var altitudeModeGroup:AltitudeModeGroup!
    public var latLonBox:LatLonBox!
    public var groundOverlaySimpleExtensionGroup:[AnyObject] = []
    public var groundOverlayObjectExtensionGroup:[AbstractObjectGroup] = []
}
