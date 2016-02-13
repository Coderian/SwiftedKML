//
//  ScreenXY.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML ScreenXY
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="screenXY" type="kml:vec2Type"/>
public class ScreenXY: HasXMLElementValue {
    public static var elementName: String = "screenXY"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? ScreenXY {
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
            case let v as ScreenOverlay: v.value.screenXY = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String]{
        var attributes:[String:String] = [:]
        attributes[value.x.dynamicType.attributeName] = String(value.x.value)
        attributes[value.xunits.dynamicType.attributeName] = value.xunits.value.rawValue.lowercaseString
        attributes[value.y.dynamicType.attributeName] = String(value.y.value)
        attributes[value.yunits.dynamicType.attributeName] = value.yunits.value.rawValue.lowercaseString
        return attributes
    }
    public var value: Vec2Type = Vec2Type() // attributes
    init(){}
    init(attributes:[String:String]){
        self.value = Vec2Type(attributes: attributes)
    }
}
