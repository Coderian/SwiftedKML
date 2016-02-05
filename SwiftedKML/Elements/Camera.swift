//
//  Camera.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Camera
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Camera" type="kml:CameraType" substitutionGroup="kml:AbstractViewGroup"/>
public class Camera : AbstractViewGroup, HasXMLElementValue {
    public static var elementName: String = "Camera"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Camera {
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
    public var childs:[HasXMLElementName] = []
    public var value : CameraType
    init(attributes:[String:String]){
        self.value = CameraType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractView : AbstractViewType { return self.value }
}
/// KML CameraType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="CameraType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractViewType">
///     <sequence>
///     <element ref="kml:longitude" minOccurs="0"/>
///     <element ref="kml:latitude" minOccurs="0"/>
///     <element ref="kml:altitude" minOccurs="0"/>
///     <element ref="kml:heading" minOccurs="0"/>
///     <element ref="kml:tilt" minOccurs="0"/>
///     <element ref="kml:roll" minOccurs="0"/>
///     <element ref="kml:altitudeModeGroup" minOccurs="0"/>
///     <element ref="kml:CameraSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:CameraObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="CameraSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="CameraObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class CameraType : AbstractViewType {
    public var longitude: Longitude?
    public var latitude: Latitude?
    public var altitude: Altitude?
    public var heading: Heading?
    public var tilt: Tilt?
    public var roll: Roll?
    public var altitudeModeGroup: AltitudeModeGroup?
    public var cameraSimpleExtensionGroup: [AnyObject] = []
    public var cameraObjectExtensionGroup: [AbstractObjectGroup] = []
}
