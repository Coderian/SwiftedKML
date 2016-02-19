//
//  Delete.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Delete
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Delete" type="kml:DeleteType"/>
public class Delete :SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "Delete"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v  as Update: v.value.createOrDeleteOrChange.append(self)
                default: break
                }
            }
        }
    }
    public var value : DeleteType = DeleteType()
}
/// KML DeleteType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="DeleteType">
///     <sequence>
///     <element ref="kml:AbstractFeatureGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </complexType>
public class DeleteType {
    public var abstractFeatureGroup: [AbstractFeatureGroup] = []
}
