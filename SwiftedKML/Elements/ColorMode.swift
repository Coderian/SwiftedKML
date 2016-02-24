//
//  ColorMode.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML ColorModeEnumType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <simpleType name="colorModeEnumType">
///     <restriction base="string">
///     <enumeration value="normal"/>
///     <enumeration value="random"/>
///     </restriction>
///     </simpleType>
public enum ColorModeEnumType:String {
    case Normal="normal", Random="random"
}
/// KML ColorMode
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="colorMode" type="kml:colorModeEnumType" default="normal"/>
public class ColorMode: SPXMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName:String = "colorMode"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as IconStyle:    v.value.colorMode = self
                case let v as LabelStyle:   v.value.colorMode = self
                case let v as LineStyle:    v.value.colorMode = self
                case let v as PolyStyle:    v.value.colorMode = self
                default: break
                }
            }
        }
    }
    public var value: ColorModeEnumType = .Normal
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = ColorModeEnumType(rawValue: contents)!
        self.parent = parent
        return parent
    }
}
