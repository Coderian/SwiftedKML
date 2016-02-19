//
//  PolyStyle.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML PolyStyle
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="PolyStyle" type="kml:PolyStyleType" substitutionGroup="kml:AbstractColorStyleGroup"/>
public class PolyStyle :SPXMLElement, AbstractColorStyleGroup, HasXMLElementValue {
    public static var elementName: String = "PolyStyle"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Style: v.value.polyStyle = self
                default: break
                }
            }
        }
    }
    public var value : PolyStyleType
    required public init(attributes:[String:String]){
        self.value = PolyStyleType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractSubStyle : AbstractSubStyleType { return self.value }
    public var abstractColorStyle : AbstractColorStyleType { return self.value }
}
/// KML PolyStyleType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="PolyStyleType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractColorStyleType">
///     <sequence>
///     <element ref="kml:fill" minOccurs="0"/>
///     <element ref="kml:outline" minOccurs="0"/>
///     <element ref="kml:PolyStyleSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:PolyStyleObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="PolyStyleSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="PolyStyleObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class PolyStyleType: AbstractColorStyleType {
    public var fill: Fill? // = true
    public var outline: Outline? // = true
    public var polyStyleSimpleExtensionGroup: [AnyObject] = []
    public var polyStyleObjectExtensionGroup: [AbstractObjectGroup] = []
}
