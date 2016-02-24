//
//  LineStyle.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML LineStyle
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
// <element name="LineStyle" type="kml:LineStyleType" substitutionGroup="kml:AbstractColorStyleGroup"/>
public class LineStyle :SPXMLElement, AbstractColorStyleGroup, HasXMLElementValue {
    public static var elementName: String = "LineStyle"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as Style: v.value.lineStyle = self
                default: break
                }
            }
        }
    }
    public var value : LineStyleType
    public required init(attributes:[String:String]){
        self.value = LineStyleType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractSubStyle : AbstractSubStyleType { return self.value }
    public var abstractColorStyle : AbstractColorStyleType { return self.value }
}
/// KML LineStyleType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="LineStyleType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractColorStyleType">
///     <sequence>
///     <element ref="kml:width" minOccurs="0"/>
///     <element ref="kml:LineStyleSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:LineStyleObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="LineStyleSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="LineStyleObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class LineStyleType: AbstractColorStyleType {
    public var width: Width! // = 1.0
    public var lineStyleSimpleExtensionGroup: [AnyObject] = []
    public var lineStyleObjectExtensionGroup: [AbstractObjectGroup] = []
}
