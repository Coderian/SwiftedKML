//
//  Link.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Link
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Link" type="kml:LinkType" substitutionGroup="kml:AbstractObjectGroup"/>
///     <element name="Url" type="kml:LinkType" substitutionGroup="kml:AbstractObjectGroup">
///     <annotation>
///     <documentation>Url deprecated in 2.2</documentation>
///     </annotation>
///     </element>
public class Link :SPXMLElement, AbstractObjectGroup, HasXMLElementValue {
    public static var elementName: String = "Link"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as Model: v.value.link = self
                default: break
                }
            }
        }
    }
    public var value : LinkType
    required public init(attributes:[String:String]){
        self.value = LinkType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
/// KML LinkType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="LinkType" final="#all">
///     <complexContent>
///     <extension base="kml:BasicLinkType">
///     <sequence>
///     <element ref="kml:refreshMode" minOccurs="0"/>
///     <element ref="kml:refreshInterval" minOccurs="0"/>
///     <element ref="kml:viewRefreshMode" minOccurs="0"/>
///     <element ref="kml:viewRefreshTime" minOccurs="0"/>
///     <element ref="kml:viewBoundScale" minOccurs="0"/>
///     <element ref="kml:viewFormat" minOccurs="0"/>
///     <element ref="kml:httpQuery" minOccurs="0"/>
///     <element ref="kml:LinkSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:LinkObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="LinkSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="LinkObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class LinkType: BasicLinkType {
    public var refreshMode: RefreshMode! // = .OnChange
    public var refreshInterval: RefreshInterval! // = 4.0
    public var viewRefreshMode: ViewRefreshMode! // = .Never
    public var viewRefreshTime: ViewRefreshTime! // = 4.0
    public var viewBoundScale: ViewBoundScale! // = 1.0
    public var viewFormat: ViewFormat!
    public var httpQuery: HttpQuery!
    public var linkSimpleExtensionGroup: [AnyObject] = []
    public var linkObjectExtensionGroup: [AbstractObjectGroup] = []
}
