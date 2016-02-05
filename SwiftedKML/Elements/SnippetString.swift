//
//  SnippetString.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML SSnippetString
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="snippet" type="string"/>
public class SnippetString: HasXMLElementSimpleValue {
    public static var elementName: String = "snippet"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? SnippetString {
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
            
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value: String = ""
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = contents
        self.parent = parent
        return parent
    }
}
