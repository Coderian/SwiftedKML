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
    case RECTANGLE, CYLINDER, SPHERE
}
/// KML Shape
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="shape" type="kml:shapeEnumType" default="rectangle"/>
public class Shape: HasXMLElementSimpleValue {
    public static var elementName: String = "shape"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Shape {
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
            case let v as PhotoOverlay: v.value.shape = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: ShapeEnumType = .RECTANGLE
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = ShapeEnumType(rawValue: contents.uppercaseString)!
        self.parent = parent
        return parent
    }
}
