//
//  Create.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Create
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Create" type="kml:CreateType"/>
public class Create :SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "Create"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Update: v.value.createOrDeleteOrChange.append(self)
                default: break
                }
            }
        }
    }
    public var value : CreateType = CreateType()
}
/// KML CreateType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="CreateType">
///     <sequence>
///     <element ref="kml:AbstractContainerGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </complexType>
public class CreateType {
    public var abstractContainerGroup: [AbstractContainerGroup] = []
}
