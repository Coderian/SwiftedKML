//
//  AbstractStyleSelector.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML AbstractStyleSelectorGroup
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="AbstractStyleSelectorGroup" type="kml:AbstractStyleSelectorType" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public protocol AbstractStyleSelectorGroup : AbstractObjectGroup {
    var abstractStyleSelector: AbstractStyleSelectorType { get }
}
/// KML AbstractStyleSelectorType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="AbstractStyleSelectorType" abstract="true">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:AbstractStyleSelectorSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:AbstractStyleSelectorObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="AbstractStyleSelectorSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="AbstractStyleSelectorObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class AbstractStyleSelectorType : AbstractObjectType {
    public var abstractStyleSelectorSimpleExtensionGroup: [AnyObject] = []
    public var abstractStyleSelectorObjectExtensionGroup: [AbstractObjectGroup] = []
}
