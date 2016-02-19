//
//  Style.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Style
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Style" type="kml:StyleType" substitutionGroup="kml:AbstractStyleSelectorGroup"/>
public class Style :SPXMLElement, AbstractStyleSelectorGroup, HasXMLElementValue {
    public static var elementName: String = "Style"
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
    public var value : StyleType
    public required init(attributes:[String:String]){
        self.value = StyleType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractStyleSelector : AbstractStyleSelectorType { return self.value }
}
/// KML StyleType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="StyleType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractStyleSelectorType">
///     <sequence>
///     <element ref="kml:IconStyle" minOccurs="0"/>
///     <element ref="kml:LabelStyle" minOccurs="0"/>
///     <element ref="kml:LineStyle" minOccurs="0"/>
///     <element ref="kml:PolyStyle" minOccurs="0"/>
///     <element ref="kml:BalloonStyle" minOccurs="0"/>
///     <element ref="kml:ListStyle" minOccurs="0"/>
///     <element ref="kml:StyleSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:StyleObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     n</complexType>
///     <element name="StyleSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="StyleObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class StyleType: AbstractStyleSelectorType {
    public var iconStyle : IconStyle?
    public var labelStyle : LabelStyle?
    public var lineStyle : LineStyle?
    public var polyStyle : PolyStyle?
    public var balloonStyle : BalloonStyle?
    public var listStyle : ListStyle?
    public var styleSimpleExtensionGroup : [AnyObject] = []
    public var styleObjectExtensionGroup : [AbstractObjectGroup] = []
}
