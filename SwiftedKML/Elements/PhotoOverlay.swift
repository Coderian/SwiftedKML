//
//  PhotoOverlay.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML PhotoOverlay
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="PhotoOverlay" type="kml:PhotoOverlayType" substitutionGroup="kml:AbstractOverlayGroup"/>
public class PhotoOverlay :SPXMLElement, AbstractOverlayGroup, HasXMLElementValue{
    public static var elementName: String = "PhotoOverlay"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
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
    public var value : PhotoOverlayType
    public required init(attributes:[String:String]){
        self.value = PhotoOverlayType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractFeature : AbstractFeatureType { return self.value }
    public var abstractOverlay : AbstractOverlayType { return self.value }
}
/// KML PhotoOverlayType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
// <complexType name="PhotoOverlayType" final="#all">
// <complexContent>
// <extension base="kml:AbstractOverlayType">
// <sequence>
// <element ref="kml:rotation" minOccurs="0"/>
// <element ref="kml:ViewVolume" minOccurs="0"/>
// <element ref="kml:ImagePyramid" minOccurs="0"/>
// <element ref="kml:Point" minOccurs="0"/>
// <element ref="kml:shape" minOccurs="0"/>
// <element ref="kml:PhotoOverlaySimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
// <element ref="kml:PhotoOverlayObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
// </sequence>
// </extension>
// </complexContent>
// </complexType>
// <element name="PhotoOverlaySimpleExtensionGroup" abstract="true" type="anySimpleType"/>
// <element name="PhotoOverlayObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class PhotoOverlayType: AbstractOverlayType {
    public var rotation:Rotation!
    public var viewVolume:ViewVolume!
    public var imagePyramid:ImagePyramid!
    public var point:Point!
    public var shape: Shape!
    public var photoOverlaySimpleExtensionGroup:[AnyObject] = []
    public var photoOverlayObjectExtensionGroup:[AbstractObjectGroup] = []
}
