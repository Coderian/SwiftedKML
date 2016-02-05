//
//  Altitude.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Altitude
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="altitude" type="double" default="0.0"/>
public class Altitude: HasXMLElementSimpleValue {
    public static var elementName:String = "altitude"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Altitude {
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
            switch self.parent {
            case let v as Camera:       v.value.altitude = self
            case let v as GroundOverlay:v.value.altitude = self
            case let v as Location:     v.value.altitude = self
            case let v as LookAt:       v.value.altitude = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value:Double = 0.0
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = Double(contents)!
        self.parent = parent
        return parent
    }
}
