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
public class Href: HasXMLElementSimpleValue {
    public static var elementName: String = "href"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Href {
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
            case let v as ItemIcon:     v.value.href = self
            case let v as IconStyleType.Icon:    v.value.href = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value: String = ""
    init(){}
    init( href : String){
        self.value = href
    }
    public func makeRelation(parent: HasXMLElementName) -> HasXMLElementName {
        self.parent = parent
        return parent
    }
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = contents
        return makeRelation(parent)
    }
}
