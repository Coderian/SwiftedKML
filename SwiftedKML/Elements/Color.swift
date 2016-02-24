//
//  Color.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Color
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="color" type="kml:colorType" default="ffffffff"/>
public class Color:SPXMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName:String = "color"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as BalloonStyle: v.value.color = self
                case let v as IconStyle:    v.value.color = self
                case let v as LabelStyle:   v.value.color = self
                case let v as LineStyle:    v.value.color = self
                case let v as PolyStyle:    v.value.color = self
                case let v as PhotoOverlay :v.value.color = self
                case let v as ScreenOverlay:v.value.color = self
                default: break
                }
            }
        }
    }
    public var value: String = "ffffffff"
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = contents
        self.parent = parent
        return parent
    }
}

// <simpleType name="colorType">
// <annotation>
// <documentation><![CDATA[
//
//    aabbggrr
//
//    ffffffff: opaque white
//    ff000000: opaque black
//
//    ]]></documentation>
// </annotation>
// <restriction base="hexBinary">
// <length value="4"/>
// </restriction>
// </simpleType>
public class colorType {
    var value:String!
}

