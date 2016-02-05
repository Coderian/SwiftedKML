//
//  RefreshMode.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML RefreshModeEnumType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <simpleType name="refreshModeEnumType">
///     <restriction base="string">
///     <enumeration value="onChange"/>
///     <enumeration value="onInterval"/>
///     <enumeration value="onExpire"/>
///     </restriction>
///     </simpleType>
public enum RefreshModeEnumType : String{
    case ONCHANGE, ONINTERVAL, ONEXPIRE
}
/// KML RefreshMode
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="refreshMode" type="kml:refreshModeEnumType" default="onChange"/>
public class RefreshMode : HasXMLElementSimpleValue {
    public static var elementName: String = "refreshMode"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? RefreshMode {
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
            case let v as Link: v.value.refreshMode = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value: RefreshModeEnumType = .ONCHANGE
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = RefreshModeEnumType(rawValue: contents.uppercaseString)!
        self.parent = parent
        return parent
    }
}
