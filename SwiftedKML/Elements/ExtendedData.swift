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
public class ExtendedData : HasXMLElementValue {
    public static var elementName: String = "ExtendedData"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? ExtendedData {
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
    public var attributes:[String:String] = [:]
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
