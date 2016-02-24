//
//  BgColor.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML BgColor
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="bgColor" type="kml:colorType" default="ffffffff"/>
public class BgColor:SPXMLElement, HasXMLElementValue,HasXMLElementSimpleValue {
    public static var elementName:String = "bgColor"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as BalloonStyle: v.value.bgColor = self
                case let v as ListStyle:    v.value.bgColor = self
                default: break
                }
            }
        }
    }
    public var value:String = "ffffffff"
    public func makeRelation(contents : String, parent: SPXMLElement) -> SPXMLElement {
        self.value = contents
        self.parent = parent
        return parent
    }
}
