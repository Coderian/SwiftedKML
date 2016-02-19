//
//  Begin.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Begin
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="begin" type="kml:dateTimeType"/>
public class Begin:SPXMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName:String = "begin"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as TimeSpan:     v.value.begin = self
                default: break
                }
            }
        }
    }
    public var value:NSDate = NSDate()
    public func makeRelation(contents : String, parent: SPXMLElement) -> SPXMLElement {
        let dateFormatter = NSDateFormatter.rfc3339Formatter(contents)
        self.value = dateFormatter.dateFromString(contents)!
        self.parent = parent
        return parent
    }
}
