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
public class NetworkLink :SPXMLElement, AbstractFeatureGroup , HasXMLElementValue{
    public static var elementName: String = "NetworkLink"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Document: v.value.abstractFeatureGroup.append(self)
                case let v as Folder:   v.value.abstractFeatureGroup.append(self)
                default: break
                }
            }
        }
    }
    public var value : NetworkLinkType
    public required init(attributes:[String:String]){
        self.value = NetworkLinkType(attributes: attributes)
        super.init(attributes: attributes)
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
    public var refreshVisibility:RefreshVisibility!
    public var flyToView:FlyToView!
//    var link:Link?
    public var networkLinkSimpleExtensionGroup:[AnyObject] = []
    public var networkLinkObjectExtensionGroup:[AbstractObjectGroup] = []
}
