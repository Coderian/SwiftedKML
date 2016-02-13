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
public class Alias : AbstractObjectGroup , HasXMLElementValue {
    public static var elementName: String = "Alias"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Alias {
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
            case let v as ResourceMap: v.value.alias.append(self)
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String]{
        var attributes:[String:String] = [:]
        if let attr = self.value.attribute {
            attributes[attr.id.dynamicType.attributeName] = attr.id.value
            attributes[attr.targetId.dynamicType.attributeName] = attr.targetId.value
        }
        return attributes
    }
    public var value : AliasType
    init(attributes:[String:String]){
        self.value = AliasType(attributes: attributes)
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
    public var targetHref: TargetHref?
    public var sourceHref: SourceHref?
    public var aliasSimpleExtensionGroup: [AnyObject] = []
    public var aliasObjectExtensionGroup: [AbstractObjectGroup] = []
}
