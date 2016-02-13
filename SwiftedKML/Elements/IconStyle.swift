//
//  IconStyle.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML IconStyle
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="IconStyle" type="kml:IconStyleType" substitutionGroup="kml:AbstractColorStyleGroup"/>
public class IconStyle : AbstractColorStyleGroup, HasXMLElementValue {
    public static var elementName: String = "IconStyle"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? IconStyle {
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
            case let v as Style: v.value.iconStyle = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value : IconStyleType
    init(){
        self.value = IconStyleType()
    }
    init(attributes:[String:String]){
        self.value = IconStyleType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractSubStyle : AbstractSubStyleType { return self.value }
    public var abstractColorStyle : AbstractColorStyleType { return self.value }
}
/// KML IconStyleType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="IconStyleType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractColorStyleType">
///     <sequence>
///     <element ref="kml:scale" minOccurs="0"/>
///     <element ref="kml:heading" minOccurs="0"/>
///     <element name="Icon" type="kml:BasicLinkType" minOccurs="0"/>
///     <element ref="kml:hotSpot" minOccurs="0"/>
///     <element ref="kml:IconStyleSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:IconStyleObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="IconStyleSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="IconStyleObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class IconStyleType: AbstractColorStyleType {
    public var scale : Scale? // = 0.0
    public var heading: Heading? // = 0.0
    /// Iconが複数あるのでStyleIconとしている
    public class Icon : HasXMLElementValue {
        public static var elementName:String = "Icon"
        public var parent:HasXMLElementName? {
            willSet {
                if newValue == nil {
                    let index = self.parent?.childs.indexOf({
                        if let v = $0 as? Description {
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
                case let v as IconStyle: v.value.icon = self
                default:break
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
        public var value: BasicLinkType = BasicLinkType()
    }
    public var icon: Icon?
    public var hotSpot: HotSpot?
    public var iconStyleSimpleExtensionGroup: [AnyObject] = []
    public var iconStyleObjectExtensionGroup: [AbstractObjectGroup] = []
}
