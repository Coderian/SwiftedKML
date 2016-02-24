//
//  LinkSnippet.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML LinkSnippet
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="linkSnippet" type="kml:SnippetType"/>
public class LinkSnippet :SPXMLElement,HasXMLElementValue,HasXMLElementSimpleValue {
    public static var elementName: String = "linkSnippet"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as NetworkLinkControl: v.value.linkSnippet = self
                default: break
                }
            }
        }
    }
    public var value: SnippetType
    public required init(attributes: [String : String]) {
        self.value = SnippetType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        // TODO:
//        self.value = contents
        self.parent = parent
        return parent
    }
}
