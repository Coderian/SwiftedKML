//
//  Coordinates.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Coordinates
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="coordinates" type="kml:coordinatesType"/>
public class Coordinates: HasXMLElementSimpleValue {
    public var description:String {
        get {
            return self.value.description
        }
    }
    public static var elementName:String = "coordinates"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Coordinates {
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
            case let v as LinearRing:   v.value.coordinates = self
            case let v as LineString:   v.value.coordinates = self
            case let v as Point:        v.value.coordinates = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    var rawValue:String = ""
    public var value:[String] = []
    public func makeRelation(contents : String, parent: HasXMLElementName) -> HasXMLElementName {
        self.rawValue = contents
        let replacestring = contents.stringByReplacingOccurrencesOfString("\n", withString: ",")
        let trimedstring = replacestring.stringByReplacingOccurrencesOfString(" ", withString: "")
//        let trimedstring = a.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        value = trimedstring.characters.split{$0 == ","}.map(String.init)
        self.parent = parent
        return parent
    }
}
