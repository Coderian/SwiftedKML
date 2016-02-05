//
//  Metadata.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Metadata
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Metadata" type="kml:MetadataType">
public class Metadata : HasXMLElementValue {
    public static var elementName: String = "Metadata"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Metadata {
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
            
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value : MetadataType = MetadataType()
}
/// KML MetadataType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <annotation>
///     <documentation>Metadata deprecated in 2.2</documentation>
///     </annotation>
///     </element>
///
///     <complexType name="MetadataType" final="#all">
///     <annotation>
///     <documentation>MetadataType deprecated in 2.2</documentation>
///     </annotation>
///     <sequence>
///     <any namespace="##any" processContents="lax" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </complexType>
public class MetadataType {
    public var any: [AnyObject] = []
}
