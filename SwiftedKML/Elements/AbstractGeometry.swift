//
//  AbstractGeometry.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML AbstractGeometryGroup
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="AbstractGeometryGroup" type="kml:AbstractGeometryType" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public protocol AbstractGeometryGroup : AbstractObjectGroup {
    var abstractGeometry : AbstractGeometryType { get }
}
/// KML AbstractGeometryType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="AbstractGeometryType" abstract="true">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:AbstractGeometrySimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:AbstractGeometryObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="AbstractGeometrySimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="AbstractGeometryObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class AbstractGeometryType : AbstractObjectType {
    public var abstractGeometrySimpleExtensionGroup: [AnyObject] = []
    public var abstractGeometryObjectExtensionGroup: [AbstractObjectGroup] = []
}
