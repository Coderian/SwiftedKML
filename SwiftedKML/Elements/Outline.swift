//
//  Outline.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Outline
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="outline" type="boolean" default="1"/>
public class Outline: HasXMLElementSimpleValue {
    public static var elementName: String = "outline"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Outline {
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
            case let v as PolyStyle: v.value.outline = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value: Bool = true // 1
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = contents == "1"
        self.parent = parent
        return parent
    }
}
