//
//  Kml.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML kml
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="kml" type="kml:KmlType">
///     <annotation>
///     <documentation><![CDATA[
///
///         <kml> is the root element.
///
///         ]]></documentation>
///     </annotation>
///     </element>
public class Kml : HasXMLElementValue , CustomStringConvertible{
    public static var elementName: String = "kml"
    public var parent:HasXMLElementName?
    public var childs:[HasXMLElementName] = []
    public var value : KmlType = KmlType()
}
/// KML KmlType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="KmlType" final="#all">
///     <sequence>
///     <element ref="kml:NetworkLinkControl" minOccurs="0"/>
///     <element ref="kml:AbstractFeatureGroup" minOccurs="0"/>
///     <element ref="kml:KmlSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:KmlObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     <attribute name="hint" type="string"/>
///     </complexType>
///     <element name="KmlSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="KmlObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class KmlType {
    public var networkLinkControl: NetworkLinkControl?
    public var abstractFeatureGroup: AbstractFeatureGroup?
    public var kmlSimpleExtensionGroup: [AnyObject] = []
    public var kmlObjectExtensionGroup: [AbstractObjectGroup] = []
    public struct Hint : XMLAttributed {
        public static var attributeName: String = "hint"
        public var value: String = ""
    }
    public var hint: Hint?
}

