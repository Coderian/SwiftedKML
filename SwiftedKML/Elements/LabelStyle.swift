//
//  LabelStyle.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML LabelStyle
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="LabelStyle" type="kml:LabelStyleType" substitutionGroup="kml:AbstractColorStyleGroup"/>
public class LabelStyle : AbstractColorStyleGroup, HasXMLElementValue {
    public static var elementName: String = "LabelStyle"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? LabelStyle {
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
            case let v as Style: v.value.labelStyle = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value : LabelStyleType
    init(attributes:[String:String]){
        self.value = LabelStyleType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractSubStyle : AbstractSubStyleType { return self.value }
    public var abstractColorStyle : AbstractColorStyleType { return self.value }
}
/// KML LabelStyleType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="LabelStyleType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractColorStyleType">
///     <sequence>
///     <element ref="kml:scale" minOccurs="0"/>
///     <element ref="kml:LabelStyleSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:LabelStyleObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="LabelStyleSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="LabelStyleObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class LabelStyleType: AbstractColorStyleType {
    public var scale: Scale? // = 0.0
    public var labelStyleSimpleExtensionGroup: [AnyObject] = []
    public var labelStyleObjectExtensionGroup: [AbstractObjectGroup] = []
}
