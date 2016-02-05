//
//  AbstractTimePrimitive.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML AbstractTimePrimitiveGroup
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="AbstractTimePrimitiveGroup" type="kml:AbstractTimePrimitiveType" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public protocol AbstractTimePrimitiveGroup : AbstractObjectGroup {
    var abstractTimePrimitive : AbstractTimePrimitiveType { get }
}
/// KML AbstractTimePrimitiveType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="AbstractTimePrimitiveType" abstract="true">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:AbstractTimePrimitiveSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:AbstractTimePrimitiveObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="AbstractTimePrimitiveSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="AbstractTimePrimitiveObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class AbstractTimePrimitiveType : AbstractObjectType {
    public var abstractTimePrimitiveSimpleExtensionGroup: [AnyObject] = []
    public var abstractTimePrimitiveObjectExtensionGroup: [AbstractObjectGroup] = []
}
