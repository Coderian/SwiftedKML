//
//  TimeStamp.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML TimeStamp
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="TimeStamp" type="kml:TimeStampType" substitutionGroup="kml:AbstractTimePrimitiveGroup"/>
public class TimeStamp : AbstractTimePrimitiveGroup, HasXMLElementValue {
    public static var elementName: String = "TimeStamp"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? TimeStamp {
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
            case let v as Document:     v.value.abstractTimePrimitiveGroup = self
            case let v as Folder:       v.value.abstractTimePrimitiveGroup = self
            case let v as Placemark:    v.value.abstractTimePrimitiveGroup = self
            case let v as NetworkLink:  v.value.abstractTimePrimitiveGroup = self
            case let v as GroundOverlay:v.value.abstractTimePrimitiveGroup = self
            case let v as PhotoOverlay: v.value.abstractTimePrimitiveGroup = self
            case let v as ScreenOverlay:v.value.abstractTimePrimitiveGroup = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value : TimeStampType
    public init(attributes:[String:String]){
        self.value = TimeStampType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractTimePrimitive : AbstractTimePrimitiveType { return self.value }
}
/// KML TimeStampType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="TimeStampType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractTimePrimitiveType">
///     <sequence>
///     <element ref="kml:when" minOccurs="0"/>
///     <element ref="kml:TimeStampSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:TimeStampObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="TimeStampSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="TimeStampObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class TimeStampType: AbstractTimePrimitiveType {
    public var when : When?
    public var timeStampSimpleExtensionGroup : [AnyObject] = []
    public var timeStampObjectExtensionGroup : [AbstractObjectGroup] = []
}
