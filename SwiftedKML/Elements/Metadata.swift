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
public class Metadata :SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "Metadata"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                    
                default: break
                }
            }
        }
    }
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
