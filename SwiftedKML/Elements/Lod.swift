//
//  Lod.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Lod
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Lod" type="kml:LodType" substitutionGroup="kml:AbstractObjectGroup"/>
public class Lod :SPXMLElement, AbstractObjectGroup, HasXMLElementValue {
    public static var elementName:String = "Lod"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Region: v.value.lod = self
                default: break
                }
            }
        }
    }
    public var value : LodType
    required public init(attributes:[String:String]){
        self.value = LodType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
/// KML LodType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="LodType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:minLodPixels" minOccurs="0"/>
///     <element ref="kml:maxLodPixels" minOccurs="0"/>
///     <element ref="kml:minFadeExtent" minOccurs="0"/>
///     <element ref="kml:maxFadeExtent" minOccurs="0"/>
///     <element ref="kml:LodSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:LodObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="LodSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="LodObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class LodType: AbstractObjectType {
    public var minLodPixels: MinLodPixels! // = 0.0
    public var maxLodPixels: MaxLodPixels! // = -1.0
    public var minFadeExtent: MinFadeExtent! // = 0.0
    public var maxFadeExtent: MaxFadeExtent! // = 0.0
    public var lodSimpleExtensionGroup: [AnyObject] = []
    public var lodObjectExtensionGroup: [AbstractObjectGroup] = []
}
