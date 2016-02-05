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
public class ListStyle : AbstractSubStyleGroup, HasXMLElementValue {
    public static var elementName: String = "ListStyle"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? ListStyle {
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
            case let v as Style: v.value.listStyle = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value : ListStyleType
    init(attributes:[String:String]){
        self.value = ListStyleType(attributes: attributes)
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
