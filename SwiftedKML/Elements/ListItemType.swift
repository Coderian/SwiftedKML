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
    case RADIOFOLDER, CHECK, CHECKHIDECHILDREN, CHECKOFFONLY
}
/// KML ListItemType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="listItemType" type="kml:listItemTypeEnumType" default="check"/>
public class ListItemType: HasXMLElementSimpleValue {
    public static var elementName: String = "listItemType"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? ListItemType {
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
            case let v as ListStyle: v.value.listItemType = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: ListItemTypeEnumType = .CHECK
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = ListItemTypeEnumType(rawValue: contents.uppercaseString)!
        self.parent = parent
        return parent
    }
}
