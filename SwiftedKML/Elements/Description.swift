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
public class Description: HasXMLElementSimpleValue {
    public static var elementName:String = "description"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Description {
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
            case let v as Document:     v.value.description = self
            case let v as Folder:       v.value.description = self
            case let v as Placemark:    v.value.description = self
            case let v as NetworkLink:  v.value.description = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value:String = ""
    init(){}
    init(value : String){
        self.value = value
    }
    public func makeRelation(contents : String, parent: HasXMLElementName) -> HasXMLElementName {
        self.value = contents
        self.parent = parent
        return parent
    }
}
