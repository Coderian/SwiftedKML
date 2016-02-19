//
//  Size.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Size
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="size" type="kml:vec2Type"/>
public class Size:SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "size"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as ScreenOverlay: v.value.size = self
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
