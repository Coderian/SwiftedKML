//
//  Icon.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Icon
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Icon" type="kml:LinkType" substitutionGroup="kml:AbstractObjectGroup"/>
public class Icon: AbstractObjectGroup, HasXMLElementValue {
    public static var elementName: String = "Icon"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Icon {
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
            case let v as GroundOverlay:v.value.icon = self
            case let v as PhotoOverlay: v.value.icon = self
            case let v as ScreenOverlay:v.value.icon = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value : LinkType
    init(attributes:[String:String]){
        self.value = LinkType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
