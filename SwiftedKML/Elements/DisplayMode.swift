//
//  DisplayMode.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML DisplayModeEnumType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <simpleType name="displayModeEnumType">
///     <restriction base="string">
///     <enumeration value="default"/>
///     <enumeration value="hide"/>
///     </restriction>
///     </simpleType>
public enum DisplayModeEnumType : String{
    case DEFAULT, HIDE
}
/// KML DisplayMode
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="displayMode" type="kml:displayModeEnumType" default="default"/>
public class DisplayMode: HasXMLElementSimpleValue {
    public static var elementName:String =  "displayMode"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? DisplayMode {
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
            case let v as BalloonStyle : v.value.displayMode = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: DisplayModeEnumType = .DEFAULT
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = DisplayModeEnumType(rawValue: contents.uppercaseString)!
        self.parent = parent
        return parent
    }
}
