//
//  AbstractContainer.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML AbstractContainerGroup
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="AbstractContainerGroup" type="kml:AbstractContainerType" abstract="true" substitutionGroup="kml:AbstractFeatureGroup"/>
public protocol AbstractContainerGroup : AbstractFeatureGroup {
    var abstractContainer : AbstractContainerType { get }
}
/// KML AbstractContainerType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="AbstractContainerType" abstract="true">
///     <complexContent>
///     <extension base="kml:AbstractFeatureType">
///     <sequence>
///     <element ref="kml:AbstractContainerSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:AbstractContainerObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="AbstractContainerSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="AbstractContainerObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class AbstractContainerType : AbstractFeatureType {
    public var abstractContainerSimpleExtensionGroup:[AnyObject] = []
    public var abstractContainerObjectExtensionGroup:[AbstractObjectGroup] = []
}
