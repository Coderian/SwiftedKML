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
public class Coordinates: SPXMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public var description:String {
        get {
            return self.value.description
        }
    }
    public static var elementName:String = "coordinates"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as LinearRing:   v.value.coordinates = self
                case let v as LineString:   v.value.coordinates = self
                case let v as Point:        v.value.coordinates = self
                default: break
                }
            }
        }
    }
    var rawValue:String = ""
    /// longitude,latitude[,altitude]
    public var value:[(longitude:String, latitude:String, altitude:String)] = []
    public func makeRelation(contents : String, parent: SPXMLElement) -> SPXMLElement {
        value.removeAll()
        self.rawValue = contents
        let trimedString = contents.componentsSeparatedByString("\n").map{$0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())}
        let separetedString = trimedString.joinWithSeparator(" ").characters.split(" ").map(String.init)
        for v in separetedString {
            let colum = v.componentsSeparatedByString(",")
            // 2 or 3 に可変する必要がある
            if colum.count == 3 {
                value.append((longitude:colum[0], latitude:colum[1], altitude:colum[2]))
            }
            else {
                value.append((longitude:colum[0], latitude:colum[1], altitude:""))
            }
        }
        self.parent = parent
        return parent
    }
}
