//
//  ScreenOverlay.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML ScreenOverlay
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="ScreenOverlay" type="kml:ScreenOverlayType" substitutionGroup="kml:AbstractOverlayGroup"/>
public class ScreenOverlay : AbstractOverlayGroup, HasXMLElementValue {
    public static var elementName : String = "ScreenOverlay"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? ScreenOverlay {
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
            case let v as Delete:   v.value.abstractFeatureGroup.append(self)
            case let v as Kml:      v.value.abstractFeatureGroup = self
            case let v as Folder:   v.value.abstractFeatureGroup.append(self)
            case let v as Document: v.value.abstractFeatureGroup.append(self)
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value : ScreenOverlayType
    public init(attributes:[String:String]){
        self.value = ScreenOverlayType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractFeature : AbstractFeatureType { return self.value }
    public var abstractOverlay : AbstractOverlayType { return self.value }
}
/// KML ScreenOverlayType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="ScreenOverlayType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractOverlayType">
///     <sequence>
///     <element ref="kml:overlayXY" minOccurs="0"/>
///     <element ref="kml:screenXY" minOccurs="0"/>
///     <element ref="kml:rotationXY" minOccurs="0"/>
///     <element ref="kml:size" minOccurs="0"/>
///     <element ref="kml:rotation" minOccurs="0"/>
///     <element ref="kml:ScreenOverlaySimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:ScreenOverlayObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="ScreenOverlaySimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="ScreenOverlayObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class ScreenOverlayType: AbstractOverlayType {
    public var overlayXY:OverlayXY?
    public var screenXY: ScreenXY?
    public var rotationXY:RotationXY?
    public var size:Size?
    public var rotation:Rotation?
    public var screenOverlaySimpleExtensionGroup:[AnyObject] = []
    public var screenOverlayObjectExtensionGroup:[AbstractObjectGroup] = []
}
