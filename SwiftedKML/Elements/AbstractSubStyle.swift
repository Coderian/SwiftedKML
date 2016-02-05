//
//  AbstractSubStyle.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML AbstractSubStyleGroup
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="AbstractSubStyleGroup" type="kml:AbstractSubStyleType" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public protocol AbstractSubStyleGroup : AbstractObjectGroup {
    var abstractSubStyle : AbstractSubStyleType { get }
}
/// KML AbstractSubStyleType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="AbstractSubStyleType" abstract="true">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:AbstractSubStyleSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:AbstractSubStyleObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="AbstractSubStyleSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="AbstractSubStyleObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class AbstractSubStyleType : AbstractObjectType {
    public var abstractSubStyleSimpleExtensionGroup: [AnyObject] = []
    public var abstractSubStyleObjectExtensionGroup: [AbstractObjectGroup] = []
}
