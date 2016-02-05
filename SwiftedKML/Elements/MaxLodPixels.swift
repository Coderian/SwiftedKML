//
//  MaxLodPixels.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML MaxLodPixels
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
/// <element name="maxLodPixels" type="double" default="-1.0"/>
public class MaxLodPixels: HasXMLElementSimpleValue {
    public static var elementName: String = "maxLodPixels"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? MaxLodPixels {
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
            case let v as Lod : v.value.maxLodPixels = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value: Double = -1.0
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = Double(contents)!
        self.parent = parent
        return parent
    }
}
