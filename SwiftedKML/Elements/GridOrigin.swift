//
//  GridOrigin.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML GridOriginEnumType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <simpleType name="gridOriginEnumType">
///     <restriction base="string">
///     <enumeration value="lowerLeft"/>
///     <enumeration value="upperLeft"/>
///     </restriction>
///     </simpleType>
public enum GridOriginEnumType : String{
    case LowerLeft="lowerLeft", UpperLeft="upperLeft"
}
/// KML GridOrigin
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="gridOrigin" type="kml:gridOriginEnumType" default="lowerLeft"/>
public class GridOrigin:SPXMLElement,HasXMLElementValue,HasXMLElementSimpleValue {
    public static var elementName: String = "gridOrigin"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as ImagePyramid: v.value.gridOrigin = self
                default: break
                }
            }
        }
    }
    public var value: GridOriginEnumType = .LowerLeft
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = GridOriginEnumType(rawValue: contents)!
        self.parent = parent
        return parent
    }
}
