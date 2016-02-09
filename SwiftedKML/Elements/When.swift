//
//  When.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML When
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="when" type="kml:dateTimeType"/>
public class When: HasXMLElementSimpleValue {
    public static var elementName:String = "when"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? When {
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
            case let v as TimeStamp: v.value.when = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: NSDate = NSDate()
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        let dateFormatter = NSDateFormatter.rfc3339Formatter(contents)
        self.value = dateFormatter.dateFromString(contents)!
        self.parent = parent
        return parent
    }
}

public extension NSDateFormatter {
    static func rfc3339Formatter(dateString:String) -> NSDateFormatter {
        var dateFormat:String
        switch dateString.characters.count {
        case 4:
            dateFormat="yyyy"
        case 7:
            dateFormat="yyyy'-'MM"
        case 10:
            dateFormat="yyyy'-'MM'-'dd"
        case 20:
            dateFormat="yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        default:
            dateFormat="yyyy'-'MM'-'dd'T'HH':'mm':'ss'XXXXXX'"
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        return dateFormatter
    }
}
