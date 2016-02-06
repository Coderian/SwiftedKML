//
//  Coordinates.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation
import MapKit

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
    /// longitude,latitude,altitude
    public var value:[(longitude:String, latitude:String, altitude:String)] = []
    public func makeRelation(contents : String, parent: HasXMLElementName) -> HasXMLElementName {
        self.rawValue = contents
        let replacestring = contents.stringByReplacingOccurrencesOfString("\n", withString: ",")
        let trimedstring = replacestring.stringByReplacingOccurrencesOfString(" ", withString: "")
//        let trimedstring = a.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let values = trimedstring.characters.split{$0 == ","}.map(String.init)
        let column = 3 // TODO: 2 or 3 に可変する必要がある スペースまでのカンマの数
        for row in 0..<values.count/column {
            if column == 3 {
                value.append((longitude:values[row*column+0], latitude:values[row*column+1], altitude:values[row*column+2]))
            }
            else {
                value.append((longitude:values[row*column+0], latitude:values[row*column+1], altitude:""))
            }
        }
        self.parent = parent
        return parent
    }
}

extension Coordinates {
    var locationCoordinates:[CLLocationCoordinate2D] {
        var ret:[CLLocationCoordinate2D]=[]
        for v in value {
            let longitude:Double = Double(v.longitude)!
            let latitude:Double = Double(v.latitude)!
            let coord = CLLocationCoordinate2DMake(latitude, longitude)
            if CLLocationCoordinate2DIsValid(coord) {
                ret.append(coord)
            }
        }
        return ret
    }
}