//
//  Placemark.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Placemark
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Placemark" type="kml:PlacemarkType" substitutionGroup="kml:AbstractFeatureGroup"/>
public class Placemark : AbstractFeatureGroup , HasXMLElementValue{
    public static var elementName: String = "Placemark"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Placemark {
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
            case let v as Document: v.value.abstractFeatureGroup.append(self)
            case let v as Folder:   v.value.abstractFeatureGroup.append(self)
            case let v as Kml:      v.value.abstractFeatureGroup = self
            case let v as Delete:   v.value.abstractFeatureGroup.append(self)
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value : PlacemarkType
    public init(attributes:[String:String]){
        self.value = PlacemarkType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractFeature : AbstractFeatureType { return self.value }
}
/// KML PlacemarkType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="PlacemarkType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractFeatureType">
///     <sequence>
///     <element ref="kml:AbstractGeometryGroup" minOccurs="0"/>
///     <element ref="kml:PlacemarkSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:PlacemarkObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="PlacemarkSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="PlacemarkObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class PlacemarkType: AbstractFeatureType {
    public var abstractGeometryGroup:AbstractGeometryGroup?
    public var placemarkSimpleExtensionGroup:[AnyObject] = []
    public var placemarkObjectExtensionGroup:[AbstractObjectGroup] = []
}
