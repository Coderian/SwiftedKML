//
//  State.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML State
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="state" type="kml:itemIconStateType"/>
public class State:SPXMLElement,HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "state"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as ItemIcon: v.value.state = self
                default: break
                }
            }
        }
    }
    public var value: ItemIconStateType = ItemIconStateType()
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        // TODO: データ用確認
//        self.value = contents
        self.parent = parent
        return parent
    }
}
