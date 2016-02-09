//
//  BgColor.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation
import UIKit

/// KML BgColor
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="bgColor" type="kml:colorType" default="ffffffff"/>
public class BgColor:HasXMLElementSimpleValue {
    public static var elementName:String = "bgColor"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? BgColor {
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
            case let v as BalloonStyle: v.value.bgColor = self
            case let v as ListStyle:    v.value.bgColor = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value:UIColor = UIColor(hexString: "ffffffff")!
    public init(){}
    public init( valueHexString : String){
        self.value = UIColor(hexString: valueHexString)!
    }
    public func makeRelation(contents : String, parent: HasXMLElementName) -> HasXMLElementName {
        self.value = UIColor(hexString: contents)!
        self.parent = parent
        return parent
    }
}
