//
//  ListItemType.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML ListItemTypeEnumType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <simpleType name="listItemTypeEnumType">
///     <restriction base="string">
///     <enumeration value="radioFolder"/>
///     <enumeration value="check"/>
///     <enumeration value="checkHideChildren"/>
///     <enumeration value="checkOffOnly"/>
///     </restriction>
///     </simpleType>
public enum ListItemTypeEnumType : String{
    case RadioFolder="radioFolder", Check="check", CheckHideChildren="checkHideChildren", CheckOffOnly="checkOffOnly"
}
/// KML ListItemType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="listItemType" type="kml:listItemTypeEnumType" default="check"/>
public class ListItemType:SPXMLElement,HasXMLElementValue,HasXMLElementSimpleValue {
    public static var elementName: String = "listItemType"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as ListStyle: v.value.listItemType = self
                default: break
                }
            }
        }
    }
    public var value: ListItemTypeEnumType = .Check
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = ListItemTypeEnumType(rawValue: contents)!
        self.parent = parent
        return parent
    }
}
