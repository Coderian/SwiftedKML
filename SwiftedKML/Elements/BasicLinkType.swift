//
//  BasicLinkType.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML BasicLinkType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="BasicLinkType">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:href" minOccurs="0"/>
///     <element ref="kml:BasicLinkSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:BasicLinkObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="BasicLinkSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="BasicLinkObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class BasicLinkType : AbstractObjectType {
    public var href: Href!
    public var basicLinkSimpleExtensionGroup: [AnyObject] = []
    public var basicLinkObjectExtensionGroup: [AbstractObjectGroup] = []
}
