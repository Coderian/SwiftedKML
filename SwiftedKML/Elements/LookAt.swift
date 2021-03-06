//
//  LookAt.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML LookAt
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="LookAt" type="kml:LookAtType" substitutionGroup="kml:AbstractViewGroup"/>
public class LookAt :SPXMLElement, AbstractViewGroup, HasXMLElementValue {
    public static var elementName: String = "LookAt"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as NetworkLinkControl:   v.value.abstractViewGroup = self
                case let v as Document:             v.value.abstractViewGroup = self
                case let v as Folder:               v.value.abstractViewGroup = self
                case let v as Placemark:            v.value.abstractViewGroup = self
                case let v as NetworkLink:          v.value.abstractViewGroup = self
                case let v as GroundOverlay:        v.value.abstractViewGroup = self
                case let v as PhotoOverlay:         v.value.abstractViewGroup = self
                case let v as ScreenOverlay:        v.value.abstractViewGroup = self
                default: break
                }
            }
        }
    }
    public var value : LookAtType
    public required init(attributes:[String:String]){
        self.value = LookAtType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractView : AbstractViewType { return self.value }
}
/// KML LookAtType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="LookAtType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractViewType">
///     <sequence>
///     <element ref="kml:longitude" minOccurs="0"/>
///     <element ref="kml:latitude" minOccurs="0"/>
///     <element ref="kml:altitude" minOccurs="0"/>
///     <element ref="kml:heading" minOccurs="0"/>
///     <element ref="kml:tilt" minOccurs="0"/>
///     <element ref="kml:range" minOccurs="0"/>
///     <element ref="kml:altitudeModeGroup" minOccurs="0"/>
///     <element ref="kml:LookAtSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:LookAtObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="LookAtSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="LookAtObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class LookAtType: AbstractViewType {
    public var longitude: Longitude! // = 0.0
    public var latitude: Latitude! // = 0.0
    public var altitude: Altitude! // = 0.0
    public var heading: Heading! // = 0.0
    public var tilt: Tilt! // = 0.0
    public var range: Range! // = 0.0
    public var altitudeModeGroup: AltitudeModeGroup!
    public var lookAtSimpleExtensionGroup : [AnyObject] = []
    public var lookAtObjectExtensionGroup : [AbstractObjectGroup] = []
}
