//
//  BalloonStyle.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML BallonStyle
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="BalloonStyle" type="kml:BalloonStyleType" substitutionGroup="kml:AbstractSubStyleGroup"/>
public class BalloonStyle :  AbstractSubStyleGroup, HasXMLElementValue {
    public static var elementName: String = "BalloonStyle"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? BalloonStyle {
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
            case let v as Style: v.value.balloonStyle = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value : BalloonStyleType
    init(attributes:[String:String]){
        self.value = BalloonStyleType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractSubStyle : AbstractSubStyleType { return self.value }
}
/// KML BalloonStyleType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="BalloonStyleType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractSubStyleType">
///     <sequence>
///     <choice>
///     <annotation>
///     <documentation>color deprecated in 2.1</documentation>
///     </annotation>
///     <element ref="kml:color" minOccurs="0"/>
///     <element ref="kml:bgColor" minOccurs="0"/>
///     </choice>
///     <element ref="kml:textColor" minOccurs="0"/>
///     <element ref="kml:text" minOccurs="0"/>
///     <element ref="kml:displayMode" minOccurs="0"/>
///     <element ref="kml:BalloonStyleSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:BalloonStyleObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="BalloonStyleSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="BalloonStyleObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class BalloonStyleType : AbstractSubStyleType {
    public var color: Color? // = UIColor(hexString:"ffffffff")!
    public var bgColor: BgColor? // = UIColor(hexString:"ffffffff")!
    public var textColor: TextColor? // = UIColor(hexString:"ff000000")!
    public var text: Text?
    public var displayMode: DisplayMode? //= .Default
    public var balloonStyleSimpleExtensionGroup: [AnyObject] = []
    public var balloonStyleObjectExtensionGroup: [AbstractObjectGroup] = []
}
