//
//  MinAltitude.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML MinAltitude
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="minAltitude" type="double" default="0.0"/>
public class MinAltitude:SPXMLElement,HasXMLElementValue,HasXMLElementSimpleValue {
    public static var elementName: String = "minAltitude"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as LatLonAltBox: v.value.minAltitude = self
                default: break
                }
            }
        }
    }
    public var value: Double = 0.0
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = Double(contents)!
        self.parent = parent
        return parent
    }
}
