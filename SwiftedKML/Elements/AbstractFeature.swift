//
//  AbstractFeature.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML AbstractFeatureGroup
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="AbstractFeatureGroup" type="kml:AbstractFeatureType" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public protocol AbstractFeatureGroup : AbstractObjectGroup {
    var abstractFeature : AbstractFeatureType { get }
}
/// KML AbstractFeatureType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="AbstractFeatureType" abstract="true">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:name" minOccurs="0"/>
///     <element ref="kml:visibility" minOccurs="0"/>
///     <element ref="kml:open" minOccurs="0"/>
///     <element ref="atom:author" minOccurs="0"/>
///     <element ref="atom:link" minOccurs="0"/>
///     <element ref="kml:address" minOccurs="0"/>
///     <element ref="xal:AddressDetails" minOccurs="0"/>
///     <element ref="kml:phoneNumber" minOccurs="0"/>
///     <choice>
///     <annotation>
///     <documentation>Snippet deprecated in 2.2</documentation>
///     </annotation>
///     <element ref="kml:Snippet" minOccurs="0"/>
///     <element ref="kml:snippet" minOccurs="0"/>
///     </choice>
///     <element ref="kml:description" minOccurs="0"/>
///     <element ref="kml:AbstractViewGroup" minOccurs="0"/>
///     <element ref="kml:AbstractTimePrimitiveGroup" minOccurs="0"/>
///     <element ref="kml:styleUrl" minOccurs="0"/>
///     <element ref="kml:AbstractStyleSelectorGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:Region" minOccurs="0"/>
///     <choice>
///     <annotation>
///     <documentation>Metadata deprecated in 2.2</documentation>
///     </annotation>
///     <element ref="kml:Metadata" minOccurs="0"/>
///     <element ref="kml:ExtendedData" minOccurs="0"/>
///     </choice>
///     <element ref="kml:AbstractFeatureSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:AbstractFeatureObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="AbstractFeatureObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
///     <element name="AbstractFeatureSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
public class AbstractFeatureType : AbstractObjectType {
    public var name: Name?
    public var visibility : Visibility?
    public var open : Open?
    /// atom:autor not supported
    public var author : AnyObject?
    /// atom:link  not supported
    public var link: AnyObject?
    public var address: Address?
    /// xal:AddressDetails not supported
    public var AddressDetails : AnyObject?
    public var phoneNumber: PhoneNumber?
    // Snippet/snippet -> deprecated in 2.2
    public var description: Description?
    public var abstractViewGroup : AbstractViewGroup?
    public var abstractTimePrimitiveGroup: AbstractTimePrimitiveGroup?
    public var styleUrl: StyleUrl?
    public var abstractStyleSelectorGroup: [AbstractStyleSelectorGroup] = []
    public var region: Region?
    // Metadata/ExtendedData -> deprecated in 2.2
    public var abstractFeatureSimpleExtensionGroup: [AnyObject] = []
    public var abstractFeatureObjectExtensionGroup: [AbstractObjectGroup] = []
}
