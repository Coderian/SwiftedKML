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
public class NetworkLinkControl : HasXMLElementValue {
    public static var elementName: String = "NetworkLinkControl"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? NetworkLinkControl {
                        return v === self
                    }
                    return false
                })
                self.parent?.childs.removeAtIndex(index!)
            }
        }
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            let selects = self.parent?.select(self.dynamicType)
            if selects!.contains({ $0 === self }) {
                return
            }
            self.parent?.childs.append(self)
            switch parent {
            case let v as Kml: v.value.networkLinkControl = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
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
    public var minRefreshPeriod: MinRefreshPeriod? // = 0.0
    public var maxSessionLength: MaxSessionLength? // = -1.0
    public var cookie: Cookie?
    public var message: Message?
    public var linkName: LinkName?
    public var linkDescription: LinkDescription?
    public var linkSnippet: LinkSnippet?
    public var expires: Expires?
    public var update: Update?
    public var abstractViewGroup: AbstractViewGroup?
    public var networkLinkControlSimpleExtensionGroup: [AnyObject] = []
    public var networkLinkControlObjectExtensionGroup: [AbstractObjectGroup] = []
}
