//
//  Href.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Href
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="href" type="string">
///     <annotation>
///     <documentation>not anyURI due to $[x] substitution in
///     PhotoOverlay</documentation>
///     </annotation>
///     </element>
public class Href:SPXMLElement,HasXMLElementValue,HasXMLElementSimpleValue {
    public static var elementName: String = "href"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as ItemIcon:     v.value.href = self
                case let v as IconStyleType.Icon:    v.value.href = self
                default: break
                }
            }
        }
    }
    public var value: String = ""
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = contents
        self.parent = parent
        return parent
    }
}
