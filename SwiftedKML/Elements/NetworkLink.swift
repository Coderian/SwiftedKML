//
//  NetworkLink.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML NetworkLink
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="NetworkLink" type="kml:NetworkLinkType" substitutionGroup="kml:AbstractFeatureGroup"/>
public class NetworkLink : AbstractFeatureGroup , HasXMLElementValue{
    public static var elementName: String = "NetworkLink"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? NetworkLink {
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
            case let v as Document: v.value.abstractFeatureGroup.append(self)
            case let v as Folder:   v.value.abstractFeatureGroup.append(self)
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value : NetworkLinkType
    public init(attributes:[String:String]){
        self.value = NetworkLinkType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractFeature : AbstractFeatureType { return self.value }
}
/// KML NetworkLinkType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="NetworkLinkType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractFeatureType">
///     <sequence>
///     <element ref="kml:refreshVisibility" minOccurs="0"/>
///     <element ref="kml:flyToView" minOccurs="0"/>
///     <choice>
///     <annotation>
///     <documentation>Url deprecated in 2.2</documentation>
///     </annotation>
///     <element ref="kml:Url" minOccurs="0"/>
///     <element ref="kml:Link" minOccurs="0"/>
///     </choice>
///     <element ref="kml:NetworkLinkSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:NetworkLinkObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="NetworkLinkSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="NetworkLinkObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class NetworkLinkType: AbstractFeatureType {
    public var refreshVisibility:RefreshVisibility?
    public var flyToView:FlyToView?
//    var link:Link?
    public var networkLinkSimpleExtensionGroup:[AnyObject] = []
    public var networkLinkObjectExtensionGroup:[AbstractObjectGroup] = []
}
