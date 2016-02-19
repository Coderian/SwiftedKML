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
public class Pair :SPXMLElement, AbstractObjectGroup, HasXMLElementValue{
    public static var elementName: String = "Pair"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as StyleMap: v.value.pair.append(self)
                default: break
                }
            }
        }
    }
    public var value : PairType
    required public init(attributes:[String:String]){
        self.value = PairType(attributes: attributes)
        super.init(attributes: attributes)
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
