//
//  Roll.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Roll
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="roll" type="kml:angle180Type" default="0.0"/>
public class Roll:SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "roll"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Camera:       v.value.roll = self
                case let v as Orientation:  v.value.roll = self
                default: break
                }
            }
        }
    }
    public var value:Double = 0.0 { // angle180Type
        willSet {
            if(newValue < -180 && 180 < newValue ){
                // TODO: Error
                return
            }
        }
    }
    func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = Double(contents)!
        self.parent = parent
        return parent
    }
}
