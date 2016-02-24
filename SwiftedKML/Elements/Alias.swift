//
//  Alias.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Alias
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Alias" type="kml:AliasType" substitutionGroup="kml:AbstractObjectGroup"/>
public class Alias : SPXMLElement, AbstractObjectGroup , HasXMLElementValue {
    public static var elementName: String = "Alias"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as ResourceMap: v.value.alias.append(self)
                default: break
                }
            }
        }
    }
    public var value : AliasType
    public required init(attributes:[String:String]){
        self.value = AliasType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject: AbstractObjectType { return self.value }
}
/// KML AliasType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="AliasType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:targetHref" minOccurs="0"/>
///     <element ref="kml:sourceHref" minOccurs="0"/>
///     <element ref="kml:AliasSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:AliasObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="AliasSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="AliasObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class AliasType : AbstractObjectType, CustomStringConvertible{
    public var description:String {
        return (targetHref?.description)! + (sourceHref?.description)!
    }
    public var targetHref: TargetHref!
    public var sourceHref: SourceHref!
    public var aliasSimpleExtensionGroup: [AnyObject] = []
    public var aliasObjectExtensionGroup: [AbstractObjectGroup] = []
}
