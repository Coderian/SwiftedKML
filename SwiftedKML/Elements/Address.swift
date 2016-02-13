//
//  Address.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Address
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="address" type="string"/>
public class Address: HasXMLElementSimpleValue {
    public static var elementName:String = "address"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Address {
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
            switch self.parent {
            case let v as NetworkLink:  v.value.address = self
            case let v as Placemark:    v.value.address = self
            case let v as Document:     v.value.address = self
            case let v as Folder :      v.value.address = self
            case let v as GroundOverlay:v.value.address = self
            case let v as PhotoOverlay: v.value.address = self
            case let v as ScreenOverlay:v.value.address = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value:String = ""
    public init(){}
    public init( value: String){
        self.value = value
    }
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName {
        self.value = contents
        self.parent = parent
        return parent
    }
}
