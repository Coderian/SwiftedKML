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
public class Lod : AbstractObjectGroup, HasXMLElementValue {
    public static var elementName:String = "Lod"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Lod {
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
            case let v as Region: v.value.lod = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value : LodType
    init(attributes:[String:String]){
        self.value = LodType(attributes: attributes)
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
    public var minLodPixels: MinLodPixels? // = 0.0
    public var maxLodPixels: MaxLodPixels? // = -1.0
    public var minFadeExtent: MinFadeExtent? // = 0.0
    public var maxFadeExtent: MaxFadeExtent? // = 0.0
    public var lodSimpleExtensionGroup: [AnyObject] = []
    public var lodObjectExtensionGroup: [AbstractObjectGroup] = []
}
