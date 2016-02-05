//
//  Pair.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Pair
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Pair" type="kml:PairType" substitutionGroup="kml:AbstractObjectGroup"/>
public class Pair : AbstractObjectGroup, HasXMLElementValue{
    public static var elementName: String = "Pair"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Pair {
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
            case let v as StyleMap: v.value.pair.append(self)
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value : PairType
    init(attributes:[String:String]){
        self.value = PairType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
}
/// KML PairType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="PairType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractObjectType">
///     <sequence>
///     <element ref="kml:key" minOccurs="0"/>
///     <element ref="kml:styleUrl" minOccurs="0"/>
///     <element ref="kml:AbstractStyleSelectorGroup" minOccurs="0"/>
///     <element ref="kml:PairSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:PairObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="PairSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="PairObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class PairType: AbstractObjectType {
    public var key: Key? // = .Normal
    public var styleUrl: StyleUrl?
    public var abstractStyleSelectorGroup: [AbstractStyleSelectorGroup] = []
    public var pairSimpleExtensionGroup: [AnyObject] = []
    public var pairObjectExtensionGroup: [AbstractObjectGroup] = []
}
