//
//  LatLonAltBox.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML AbstractlatLonBoxType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="AbstractLatLonBoxType" abstract="true">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:north" minOccurs="0"/>
///     <element ref="kml:south" minOccurs="0"/>
///     <element ref="kml:east" minOccurs="0"/>
///     <element ref="kml:west" minOccurs="0"/>
///     <element ref="kml:AbstractLatLonBoxSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:AbstractLatLonBoxObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="AbstractLatLonBoxSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="AbstractLatLonBoxObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class AbstractLatLonBoxType : AbstractObjectType {
    public var north: North! // = 180.0
    public var south: South! // = -180.0
    public var east: East! // = 180.0
    public var west: West! // = -180.0
    public var abstractLatLonBoxSimpleExtensionGroup: [AnyObject] = []
    public var abstractLatLonBoxObjectExtensionGroup: [AbstractObjectGroup] = []
}
/// KML LatLonAltBox
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="LatLonAltBox" type="kml:LatLonAltBoxType" substitutionGroup="kml:AbstractObjectGroup"/>
public class LatLonAltBox :SPXMLElement, AbstractObjectGroup, HasXMLElementValue {
    public static var elementName : String = "LatLonAltBox"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as Region: v.value.latLonAltBox = self
                default: break
                }
            }
        }
    }
    public var value : LatLonAltBoxType
    public required init(attributes:[String:String]){
        self.value = LatLonAltBoxType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
/// KML LatLonAltBoxType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="LatLonAltBoxType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractLatLonBoxType">
///     <sequence>
///     <element ref="kml:minAltitude" minOccurs="0"/>
///     <element ref="kml:maxAltitude" minOccurs="0"/>
///     <element ref="kml:altitudeModeGroup" minOccurs="0"/>
///     <element ref="kml:LatLonAltBoxSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:LatLonAltBoxObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="LatLonAltBoxSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="LatLonAltBoxObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class LatLonAltBoxType: AbstractLatLonBoxType {
    public var minAltitude: MinAltitude! // = 0.0
    public var maxAltitude: MaxAltitude! // = 0.0
    public var altitudeModeGroup: AltitudeModeGroup!
    public var latLonAltBoxSimpleExtensionGroup: [AnyObject] = []
    public var latLonAltBoxObjectExtensionGroup: [AbstractObjectGroup] = []
}
