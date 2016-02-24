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
    case Default="default", Hide="hide"
}
/// KML DisplayMode
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="displayMode" type="kml:displayModeEnumType" default="default"/>
public class DisplayMode:SPXMLElement,HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName:String =  "displayMode"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as BalloonStyle : v.value.displayMode = self
                default: break
                }
            }
        }
    }
    public var value: DisplayModeEnumType = .Default
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = DisplayModeEnumType(rawValue: contents)!
        self.parent = parent
        return parent
    }
}
