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
public class Icon:SPXMLElement, AbstractObjectGroup, HasXMLElementValue {
    public static var elementName: String = "Icon"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as GroundOverlay:v.value.icon = self
                case let v as PhotoOverlay: v.value.icon = self
                case let v as ScreenOverlay:v.value.icon = self
                default: break
                }
            }
        }
    }
    public var value : LinkType
    required public init(attributes:[String:String]){
        self.value = LinkType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
