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
    case Normal="normal", Highlight="highlight"
}
/// KML Key
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="key" type="kml:styleStateEnumType" default="normal"/>
public class Key:SPXMLElement,HasXMLElementValue,HasXMLElementSimpleValue {
    public static var elementName: String = "key"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Pair: v.value.key = self
                default: break
                }
            }
        }
    }
    public var value: StyleStateEnumType = .Normal
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = StyleStateEnumType(rawValue: contents)!
        self.parent = parent
        return parent
    }
}
