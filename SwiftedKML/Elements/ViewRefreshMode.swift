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
    case Never="never", OnRequest="onRequest", OnStop="onStop", OnRegion="onRegion"
}
/// KML ViewRefreshMode
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="viewRefreshMode" type="kml:viewRefreshModeEnumType" default="never"/>
public class ViewRefreshMode:SPXMLElement,HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "viewRefreshMode"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as Link: v.value.viewRefreshMode = self
                default: break
                }
            }
        }
    }
    public var value: ViewRefreshModeEnumType = .Never
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = ViewRefreshModeEnumType(rawValue: contents.uppercaseString)!
        self.parent = parent
        return parent
    }
}
