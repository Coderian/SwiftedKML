//
//  Shape.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML ShapeEnumType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <simpleType name="shapeEnumType">
///     <restriction base="string">
///     <enumeration value="rectangle"/>
///     <enumeration value="cylinder"/>
///     <enumeration value="sphere"/>
///     </restriction>
///     </simpleType>
public enum ShapeEnumType : String {
    case RECTANGLE="rectangle", CYLINDER="cylinder", SPHERE="sphere"
}
/// KML Shape
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="shape" type="kml:shapeEnumType" default="rectangle"/>
public class Shape:SPXMLElement,HasXMLElementValue,HasXMLElementSimpleValue {
    public static var elementName: String = "shape"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as PhotoOverlay: v.value.shape = self
                default: break
                }
            }
        }
    }
    public var value: ShapeEnumType = .RECTANGLE
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = ShapeEnumType(rawValue: contents)!
        self.parent = parent
        return parent
    }
}
