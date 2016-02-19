//
//  MultiGeometry.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML MultiGeometry
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="MultiGeometry" type="kml:MultiGeometryType" substitutionGroup="kml:AbstractGeometryGroup"/>
public class MultiGeometry :SPXMLElement, AbstractGeometryGroup , HasXMLElementValue {
    public static var elementName: String = "MultiGeometry"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as MultiGeometry:v.value.abstractGeometryGroup.append(self)
                case let v as Placemark:    v.value.abstractGeometryGroup = self
                default: break
                }
            }
        }
    }
    public var value : MultiGeometryType
    public required init(attributes:[String:String]){
        self.value = MultiGeometryType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractGeometry : AbstractGeometryType { return self.value }
}
/// KML MultiGeometryType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="MultiGeometryType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractGeometryType">
///     <sequence>
///     <element ref="kml:AbstractGeometryGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:MultiGeometrySimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:MultiGeometryObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="MultiGeometrySimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="MultiGeometryObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class MultiGeometryType: AbstractGeometryType {
    public var abstractGeometryGroup: [AbstractGeometryGroup] = []
    public var multiGeometrySimpleExtensionGroup: [AnyObject] = []
    public var multiGeometryObjectExtensionGroup: [AbstractObjectGroup] = []
}
