//
//  Description.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Description element
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="description" type="string"/>
public class Description:SPXMLElement,HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName:String = "description"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Document:     v.value.description = self
                case let v as Folder:       v.value.description = self
                case let v as Placemark:    v.value.description = self
                case let v as NetworkLink:  v.value.description = self
                default: break
                }
            }
        }
    }
    public var value:String = ""
    public func makeRelation(contents : String, parent: SPXMLElement) -> SPXMLElement {
        self.value = contents
        self.parent = parent
        return parent
    }
}
