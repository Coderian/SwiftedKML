//
//  AbstractColorStyle.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML AbstractColorStyleGroup
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="AbstractColorStyleGroup" type="kml:AbstractColorStyleType" abstract="true" substitutionGroup="kml:AbstractSubStyleGroup"/>
public protocol AbstractColorStyleGroup : AbstractSubStyleGroup {
    var abstractColorStyle : AbstractColorStyleType { get }
}

/// KML AbstractColorStyleType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
/// 
///     <complexType name="AbstractColorStyleType" abstract="true">
///     <complexContent>
///     <extension base="kml:AbstractSubStyleType">
///     <sequence>
///     <element ref="kml:color" minOccurs="0"/>
///     <element ref="kml:colorMode" minOccurs="0"/>
///     <element ref="kml:AbstractColorStyleSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:AbstractColorStyleObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="AbstractColorStyleObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
///     <element name="AbstractColorStyleSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
public class AbstractColorStyleType : AbstractSubStyleType {
    public var color: Color!
    public var colorMode: ColorMode!
    public var abstractColorStyleSimpleExtensionGroup : [AnyObject] = []
    public var abstractColorStyleObjectExtensionGroup : [AbstractObjectGroup] = []
}
