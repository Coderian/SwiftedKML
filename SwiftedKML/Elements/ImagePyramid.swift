//
//  ImagePyramid.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML ImagePyramid
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="ImagePyramid" type="kml:ImagePyramidType" substitutionGroup="kml:AbstractObjectGroup"/>
public class ImagePyramid : AbstractObjectGroup, HasXMLElementValue {
    public static var elementName:String = "ImagePyramid"
    public var parent:HasXMLElementName? {
        didSet {
            self.parent?.childs.append(self)
            switch parent {
            case let v as PhotoOverlay: v.value.imagePyramid = self
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
    public var value : ImagePyramidType
    init(attributes:[String:String]){
        self.value = ImagePyramidType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
/// KML ImagePyramidType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="ImagePyramidType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:tileSize" minOccurs="0"/>
///     <element ref="kml:maxWidth" minOccurs="0"/>
///     <element ref="kml:maxHeight" minOccurs="0"/>
///     <element ref="kml:gridOrigin" minOccurs="0"/>
///     <element ref="kml:ImagePyramidSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:ImagePyramidObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="ImagePyramidSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="ImagePyramidObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class ImagePyramidType: AbstractObjectType {
    public var tileSize: TileSize? // = 256
    public var maxWidth: MaxWidth? // = 0
    public var maxHeight: MaxHeight? // = 0
    public var gridOrigin: GridOrigin? // = GridOriginEnumType.LowerLeft
    public var imagePyramidSimpleExtensionGroup : [AnyObject] = []
    public var imagePyramidObjectExtensionGroup : [AbstractObjectGroup] = []
}
