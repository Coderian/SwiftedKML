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
public class Delete : HasXMLElementValue {
    public static var elementName: String = "Delete"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Delete {
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
            case let v  as Update: v.value.createOrDeleteOrChange.append(self)
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
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
