//
//  RotationXY.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML RotationXY
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="rotationXY" type="kml:vec2Type"/>
public class RotationXY:SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "rotationXY"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as ScreenOverlay: v.value.rotationXY = self
                default: break
                }
            }
        }
    }
    public var value: Vec2Type = Vec2Type() // attributes
    required public init(attributes:[String:String]){
        self.value = Vec2Type(attributes: attributes)
        super.init(attributes: attributes)
    }
}
