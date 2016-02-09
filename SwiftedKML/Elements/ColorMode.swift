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
    case NORMAL, RANDOM
}
/// KML ColorMode
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="colorMode" type="kml:colorModeEnumType" default="normal"/>
public class ColorMode: HasXMLElementSimpleValue {
    public static var elementName:String = "colorMode"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? ColorMode {
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
            case let v as IconStyle:    v.value.colorMode = self
            case let v as LabelStyle:   v.value.colorMode = self
            case let v as LineStyle:    v.value.colorMode = self
            case let v as PolyStyle:    v.value.colorMode = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: ColorModeEnumType = .NORMAL
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = ColorModeEnumType(rawValue: contents.uppercaseString)!
        self.parent = parent
        return parent
    }
}
