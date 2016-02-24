//
//  NetworkLinkControl.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML NetworkLinkControl
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="NetworkLinkControl" type="kml:NetworkLinkControlType"/>
public class NetworkLinkControl :SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "NetworkLinkControl"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Kml: v.value.networkLinkControl = self
                default: break
                }
            }
        }
    }
    public var value : NetworkLinkControlType = NetworkLinkControlType()
}
/// KML NetworkLinkControlType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="NetworkLinkControlType" final="#all">
///     <sequence>
///     <element ref="kml:minRefreshPeriod" minOccurs="0"/>
///     <element ref="kml:maxSessionLength" minOccurs="0"/>
///     <element ref="kml:cookie" minOccurs="0"/>
///     <element ref="kml:message" minOccurs="0"/>
///     <element ref="kml:linkName" minOccurs="0"/>
///     <element ref="kml:linkDescription" minOccurs="0"/>
///     <element ref="kml:linkSnippet" minOccurs="0"/>
///     <element ref="kml:expires" minOccurs="0"/>
///     <element ref="kml:Update" minOccurs="0"/>
///     <element ref="kml:AbstractViewGroup" minOccurs="0"/>
///     <element ref="kml:NetworkLinkControlSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:NetworkLinkControlObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </complexType>
///     <element name="NetworkLinkControlSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="NetworkLinkControlObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class NetworkLinkControlType {
    public var minRefreshPeriod: MinRefreshPeriod! // = 0.0
    public var maxSessionLength: MaxSessionLength! // = -1.0
    public var cookie: Cookie!
    public var message: Message!
    public var linkName: LinkName!
    public var linkDescription: LinkDescription!
    public var linkSnippet: LinkSnippet!
    public var expires: Expires!
    public var update: Update!
    public var abstractViewGroup: AbstractViewGroup!
    public var networkLinkControlSimpleExtensionGroup: [AnyObject] = []
    public var networkLinkControlObjectExtensionGroup: [AbstractObjectGroup] = []
}
