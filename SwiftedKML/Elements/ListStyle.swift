//
//  ListStyle.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML ListStyle
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="ListStyle" type="kml:ListStyleType" substitutionGroup="kml:AbstractSubStyleGroup"/>
public class ListStyle :SPXMLElement, AbstractSubStyleGroup, HasXMLElementValue {
    public static var elementName: String = "ListStyle"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Style: v.value.listStyle = self
                default: break
                }
            }
        }
    }
    public var value : ListStyleType
    required public init(attributes:[String:String]){
        self.value = ListStyleType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractSubStyle : AbstractSubStyleType { return self.value }
}
/// KML ListStyleType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="ListStyleType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractSubStyleType">
///     <sequence>
///     <element ref="kml:listItemType" minOccurs="0"/>
///     <element ref="kml:bgColor" minOccurs="0"/>
///     <element ref="kml:ItemIcon" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:maxSnippetLines" minOccurs="0"/>
///     <element ref="kml:ListStyleSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:ListStyleObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="ListStyleSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="ListStyleObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class ListStyleType: AbstractSubStyleType {
    public var listItemType: ListItemType? // = .Check
    public var bgColor: BgColor? // = UIColor(hexString:"ffffffff")!
    public var itemIcon: [ItemIcon] = []
    public var maxSnippetLines: MaxSnippetLines? // = 2
    public var listStyleSimpleExtensionGroup: [AnyObject] = []
    public var listStyleObjectExtensionGroup: [AbstractObjectGroup] = []
}
