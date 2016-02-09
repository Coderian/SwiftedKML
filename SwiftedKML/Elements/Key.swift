//
//  Key.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML StyleStateEnumType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <simpleType name="styleStateEnumType">
///     <restriction base="string">
///     <enumeration value="normal"/>
///     <enumeration value="highlight"/>
///     </restriction>
///     </simpleType>
public enum StyleStateEnumType : String {
    case NORMAL, HIGHLIGHT
}
/// KML Key
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="key" type="kml:styleStateEnumType" default="normal"/>
public class Key: HasXMLElementSimpleValue {
    public static var elementName: String = "key"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Key {
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
            case let v as Pair: v.value.key = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: StyleStateEnumType = .NORMAL
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = StyleStateEnumType(rawValue: contents.uppercaseString)!
        self.parent = parent
        return parent
    }
}
