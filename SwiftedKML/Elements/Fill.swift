//
//  Fill.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Fill
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="fill" type="boolean" default="1"/>
public class Fill:SPXMLElement,HasXMLElementValue,HasXMLElementSimpleValue {
    public static var elementName: String =  "fill"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as PolyStyle: v.value.fill = self
                default: break
                }
            }
        }
    }
    public var value:Bool = true // 1
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = contents == "1"
        self.parent = parent
        return parent
    }
}
