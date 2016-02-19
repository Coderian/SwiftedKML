//
//  StyleMap.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML StyleMap
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="StyleMap" type="kml:StyleMapType" substitutionGroup="kml:AbstractStyleSelectorGroup"/>
public class StyleMap :SPXMLElement, AbstractStyleSelectorGroup, HasXMLElementValue {
    public static var elementName: String = "StyleMap"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Document:     v.value.abstractStyleSelectorGroup.append(self)
                case let v as Folder:       v.value.abstractStyleSelectorGroup.append(self)
                case let v as Placemark:    v.value.abstractStyleSelectorGroup.append(self)
                case let v as NetworkLink:  v.value.abstractStyleSelectorGroup.append(self)
                case let v as GroundOverlay:v.value.abstractStyleSelectorGroup.append(self)
                case let v as PhotoOverlay: v.value.abstractStyleSelectorGroup.append(self)
                case let v as ScreenOverlay:v.value.abstractStyleSelectorGroup.append(self)
                case let v as Pair:         v.value.abstractStyleSelectorGroup.append(self)
                default: break
                }
            }
        }
    }
    public var value : StyleMapType
    public required init(attributes:[String:String]){
        self.value = StyleMapType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractStyleSelector : AbstractStyleSelectorType { return self.value }
}
/// KML StyleMapType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="StyleMapType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractStyleSelectorType">
///     <sequence>
///     <element ref="kml:Pair" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:StyleMapSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:StyleMapObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="StyleMapSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="StyleMapObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class StyleMapType: AbstractStyleSelectorType {
    public var pair: [Pair] = []
    public var styleMapSimpleExtensionGroup: [AnyObject] = []
    public var styleMapObjectExtensionGroup: [AbstractObjectGroup] = []
}
