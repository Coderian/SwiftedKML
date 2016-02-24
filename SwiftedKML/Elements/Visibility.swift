//
//  Visibility.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Visibility
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="visibility" type="boolean" default="1"/>
public class Visibility:SPXMLElement,HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "visibility"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as Document:     v.value.visibility = self
                case let v as Folder:       v.value.visibility = self
                case let v as Placemark:    v.value.visibility = self
                case let v as NetworkLink:  v.value.visibility = self
                case let v as GroundOverlay:v.value.visibility = self
                case let v as PhotoOverlay: v.value.visibility = self
                case let v as ScreenOverlay:v.value.visibility = self
                default: break
                }
            }
        }
    }
    public var value: Bool = true // 1
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = contents == "1"
        self.parent = parent
        return parent
    }
}
