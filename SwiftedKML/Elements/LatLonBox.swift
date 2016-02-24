//
//  LatLonBox.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML LatLonBox
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="LatLonBox" type="kml:LatLonBoxType" substitutionGroup="kml:AbstractObjectGroup"/>
public class LatLonBox :SPXMLElement, AbstractObjectGroup, HasXMLElementValue {
    public static var elementName: String = "LatLonBox"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as GroundOverlay: v.value.latLonBox = self
                default: break
                }
            }
        }
    }
    public var value : LatLonBoxType
    public required init(attributes:[String:String]){
        self.value = LatLonBoxType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
/// KML LatLonBoxType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="LatLonBoxType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractLatLonBoxType">
///     <sequence>
///     <element ref="kml:rotation" minOccurs="0"/>
///     <element ref="kml:LatLonBoxSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:LatLonBoxObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="LatLonBoxSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="LatLonBoxObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class LatLonBoxType: AbstractLatLonBoxType {
    public var rotation: Rotation! // = 0.0
    public var latLonBoxSimpleExtensionGroup: [AnyObject] = []
    public var latLonBoxObjectExtensionGroup: [AbstractObjectGroup] = []
}
