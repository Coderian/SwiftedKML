//
//  AbstractView.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML AbstractViewGroup
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="AbstractViewGroup" type="kml:AbstractViewType" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public protocol AbstractViewGroup : AbstractObjectGroup {
    var abstractView : AbstractViewType { get }
}
/// KML AbstractViewType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="AbstractViewType" abstract="true">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:AbstractViewSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:AbstractViewObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="AbstractViewSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="AbstractViewObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class AbstractViewType : AbstractObjectType {
    public var abstractViewSimpleExtensionGroup: [AnyObject] = []
    public var abstractViewObjectExtensionGroup: [AbstractObjectGroup] = []
}
