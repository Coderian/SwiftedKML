//
//  ExtendedData.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML ExtendedData
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="ExtendedData" type="kml:ExtendedDataType"/>
public class ExtendedData :SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "ExtendedData"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                    
                default: break
                }
            }
        }
    }
    public var value : ExtendedDataType = ExtendedDataType()
}
/// KML ExtendedDataType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="ExtendedDataType" final="#all">
///     <sequence>
///     <element ref="kml:Data" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:SchemaData" minOccurs="0" maxOccurs="unbounded"/>
///     <any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </complexType>
public class ExtendedDataType {
    public var data : [Data] = []
    public var schemaData: [SchemaData] = []
    public var any: [AnyObject] = []
}
