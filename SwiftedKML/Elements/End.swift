//
//  End.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML End
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="end" type="kml:dateTimeType"/>
public class End: HasXMLElementSimpleValue {
    public static var elementName: String = "end"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? End {
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
            case let v as TimeSpan:     v.value.end = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value:NSDate = NSDate()
    public func makeRelation(parent: HasXMLElementName) -> HasXMLElementName {
        self.parent = parent
        return parent
    }
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = NSDate()
        return makeRelation(parent)
    }
}
