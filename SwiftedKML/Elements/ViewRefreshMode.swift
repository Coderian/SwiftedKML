//
//  ViewRefreshMode.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML ViewRefreshModeEnumType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <simpleType name="viewRefreshModeEnumType">
///     <restriction base="string">
///     <enumeration value="never"/>
///     <enumeration value="onRequest"/>
///     <enumeration value="onStop"/>
///     <enumeration value="onRegion"/>
///     </restriction>
///     </simpleType>
public enum ViewRefreshModeEnumType : String {
    case NEVER, ONREQUEST, ONSTOP, ONREGION
}
/// KML ViewRefreshMode
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="viewRefreshMode" type="kml:viewRefreshModeEnumType" default="never"/>
public class ViewRefreshMode: HasXMLElementSimpleValue {
    public static var elementName: String = "viewRefreshMode"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? ViewRefreshMode {
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
            case let v as Link: v.value.viewRefreshMode = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value: ViewRefreshModeEnumType = .NEVER
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = ViewRefreshModeEnumType(rawValue: contents.uppercaseString)!
        self.parent = parent
        return parent
    }
}
