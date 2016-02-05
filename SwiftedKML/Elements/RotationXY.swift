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
public class RotationXY: HasXMLElementValue {
    public static var elementName: String = "rotationXY"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? RotationXY {
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
            case let v as ScreenOverlay: v.value.rotationXY = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value: Vec2Type = Vec2Type() // attributes
    init(){}
    init(attributes:[String:String]){
        self.value = Vec2Type(attributes: attributes)
    }
}
