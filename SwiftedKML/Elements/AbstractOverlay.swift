//
//  AbstractOverlay.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML AbstractOverlayGroup
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="AbstractOverlayGroup" type="kml:AbstractOverlayType" abstract="true" substitutionGroup="kml:AbstractFeatureGroup"/>
public protocol AbstractOverlayGroup : AbstractFeatureGroup {
    var abstractOverlay : AbstractOverlayType { get }
}
/// KML AbstractOverlayType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="AbstractOverlayType" abstract="true">
///     <complexContent>
///     <extension base="kml:AbstractFeatureType">
///     <sequence>
///     <element ref="kml:color" minOccurs="0"/>
///     <element ref="kml:drawOrder" minOccurs="0"/>
///     <element ref="kml:Icon" minOccurs="0"/>
///     <element ref="kml:AbstractOverlaySimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:AbstractOverlayObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="AbstractOverlaySimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="AbstractOverlayObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class AbstractOverlayType : AbstractFeatureType {
    public var color: Color!
    public var drawOrder: DrawOrder!
    public var icon: Icon!
    public var abstractOverlaySimpleExtensionGroup: [AnyObject] = []
    public var abstractOverlayObjectExtensionGroup: [AbstractObjectGroup] = []
}
