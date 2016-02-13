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
public class LinkSnippet : HasXMLElementSimpleValue {
    public static var elementName: String = "linkSnippet"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? LinkSnippet {
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
            case let v as NetworkLinkControl: v.value.linkSnippet = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: SnippetType
    init(attribute:[String:String]){
        self.value = SnippetType(attributes: attribute)
    }
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        // TODO:
//        self.value = contents
        self.parent = parent
        return parent
    }
}
