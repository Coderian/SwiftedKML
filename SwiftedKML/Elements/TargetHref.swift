//
//  TargetHref.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML TargetHref
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
/// <element name="targetHref" type="anyURI"/>
public class TargetHref: HasXMLElementSimpleValue {
    public static var elementName: String = "targetHref"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? TargetHref {
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
            case let v as Alias : v.value.targetHref = self
            case let v as Update: v.value.targetHref = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: String = String() // TODO: #globalIconなどの自己参照があるので要検討
    public func makeRelation(contents: String, parent: HasXMLElementName) -> HasXMLElementName {
        self.value = contents
        self.parent = parent
        return parent
    }
}
