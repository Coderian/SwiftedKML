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
public class PhotoOverlay : AbstractOverlayGroup, HasXMLElementValue{
    public static var elementName: String = "PhotoOverlay"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? PhotoOverlay {
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
            case let v as Delete:   v.value.abstractFeatureGroup.append(self)
            case let v as Kml:      v.value.abstractFeatureGroup = self
            case let v as Folder:   v.value.abstractFeatureGroup.append(self)
            case let v as Document: v.value.abstractFeatureGroup.append(self)
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String]{
        var attributes:[String:String] = [:]
        if let attr = self.value.attribute {
            attributes[attr.id.dynamicType.attributeName] = attr.id.value
            attributes[attr.targetId.dynamicType.attributeName] = attr.targetId.value
        }
        return attributes
    }
    public var value : PhotoOverlayType
    public init(attributes:[String:String]){
        self.value = PhotoOverlayType(attributes: attributes)
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
    public var rotation:Rotation?
    public var viewVolume:ViewVolume?
    public var imagePyramid:ImagePyramid?
    public var point:Point?
    public var shape: Shape?
    public var photoOverlaySimpleExtensionGroup:[AnyObject] = []
    public var photoOverlayObjectExtensionGroup:[AbstractObjectGroup] = []
}
