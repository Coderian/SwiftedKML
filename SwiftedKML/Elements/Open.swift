//
//  Open.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Open
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="open" type="boolean" default="0"/>
public class Open: HasXMLElementSimpleValue {
    public static var elementName: String = "open"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Open {
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
            case let v as Document:     v.value.open = self
            case let v as Folder:       v.value.open = self
            case let v as Placemark:    v.value.open = self
            case let v as NetworkLink:  v.value.open = self
            case let v as GroundOverlay:v.value.open = self
            case let v as PhotoOverlay: v.value.open = self
            case let v as ScreenOverlay:v.value.open = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: Bool = false // 0
    init(){}
    init(value :Bool){
        self.value = value
    }
    public func makeRelation(contents: String, parent: HasXMLElementName) -> HasXMLElementName {
        self.value = contents == "1"
        self.parent = parent
        return parent
    }
}
