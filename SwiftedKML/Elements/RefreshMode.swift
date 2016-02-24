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
    case OnChange="onChange", OnInterval="onInterval", OnExpire="onExpire"
}
/// KML RefreshMode
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="refreshMode" type="kml:refreshModeEnumType" default="onChange"/>
public class RefreshMode :SPXMLElement,HasXMLElementValue,HasXMLElementSimpleValue {
    public static var elementName: String = "refreshMode"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as Link: v.value.refreshMode = self
                default: break
                }
            }
        }
    }
    public var value: RefreshModeEnumType = .OnChange
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = RefreshModeEnumType(rawValue: contents)!
        self.parent = parent
        return parent
    }
}
