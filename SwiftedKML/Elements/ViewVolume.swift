//
//  ViewVolume.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML ViewVolume
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="ViewVolume" type="kml:ViewVolumeType" substitutionGroup="kml:AbstractObjectGroup"/>
public class ViewVolume : AbstractObjectGroup ,HasXMLElementValue {
    public static var elementName: String = "ViewVolume"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? ViewVolume {
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
            case let v as PhotoOverlay: v.value.viewVolume = self
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
    public var value : ViewVolumeType
    public init(attributes:[String:String]){
        self.value = ViewVolumeType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
/// KML ViewVolumeType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="ViewVolumeType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:leftFov" minOccurs="0"/>
///     <element ref="kml:rightFov" minOccurs="0"/>
///     <element ref="kml:bottomFov" minOccurs="0"/>
///     <element ref="kml:topFov" minOccurs="0"/>
///     <element ref="kml:near" minOccurs="0"/>
///     <element ref="kml:ViewVolumeSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:ViewVolumeObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="ViewVolumeSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="ViewVolumeObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class ViewVolumeType: AbstractObjectType {
    public var leftFov: LeftFov? // = 0.0
    public var rightFov: RightFov? // = 0.0
    public var bottomFov: BottomFov? // = 0.0
    public var topFov: TopFov? // = 0.0
    public var near: Near? // = 0.0
    public var viewVolumeSimpleExtensionGroup: [AnyObject] = []
    public var viewVolumeObjectExtensionGroup: [AbstractObjectGroup] = []
}
