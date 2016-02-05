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
    case LOWERLEFT, UPPERLEFT
}
/// KML GridOrigin
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="gridOrigin" type="kml:gridOriginEnumType" default="lowerLeft"/>
public class GridOrigin: HasXMLElementSimpleValue {
    public static var elementName: String = "gridOrigin"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? GridOrigin {
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
            case let v as ImagePyramid: v.value.gridOrigin = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value: GridOriginEnumType = .LOWERLEFT
    public func makeRelation(parent: HasXMLElementName) -> HasXMLElementName {
        self.parent = parent
        return parent
    }
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = GridOriginEnumType(rawValue: contents.uppercaseString)!
        return makeRelation(parent)
    }
}
