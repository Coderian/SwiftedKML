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
public class Address: SPXMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName:String = "address"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
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
    }
    public var value:String = ""
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement {
        self.value = contents
        self.parent = parent
        return parent
    }
}
