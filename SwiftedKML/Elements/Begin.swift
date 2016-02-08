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
public class Begin:HasXMLElementSimpleValue {
    public static var elementName:String = "begin"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Begin {
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
            case let v as TimeSpan:     v.value.begin = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value:NSDate = NSDate()
    public func makeRelation(contents : String, parent: HasXMLElementName) -> HasXMLElementName {
        var datefmt = ""
        switch contents.characters.count {
        case 4:
            datefmt="yyyy"
        case 7:
            datefmt="yyyy'-'MM"
        case 10:
            datefmt="yyyy'-'MM'-'dd"
        case 20:
            datefmt="yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        default:
            datefmt="yyyy'-'MM'-'dd'T'HH':'mm':'ss'XXXXXX'"
        }
        let dateFormater = NSDateFormatter()
        dateFormater.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormater.dateFormat = datefmt
        dateFormater.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        self.value = dateFormater.dateFromString(contents)!
        self.parent = parent
        return parent
    }
}
