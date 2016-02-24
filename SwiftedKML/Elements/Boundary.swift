//
//  Boundary.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML OuterBoundaryIs
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="outerBoundaryIs" type="kml:BoundaryType"/>
public class OuterBoundaryIs : SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "outerBoundaryIs"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Polygon: v.value.outerBoundaryIs = self
                default: break
                }
            }
        }
    }
    public var value : BoundaryType = BoundaryType()
}
/// KML InnerBoundaryIs
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="innerBoundaryIs" type="kml:BoundaryType"/>
public class InnerBoundaryIs : SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "innerBoundaryIs"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Polygon: v.value.innerBoundaryIs = self
                default: break
                }
            }
        }
    }
    public var value : BoundaryType = BoundaryType()
}
/// KML BoundaryType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="BoundaryType" final="#all">
///     <sequence>
///     <element ref="kml:LinearRing" minOccurs="0"/>
///     <element ref="kml:BoundarySimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:BoundaryObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </complexType>
public class BoundaryType {
    public var linearRing: LinearRing!
    public var boundarySimpleExtensionGroup: [AnyObject] = []
    public var boundaryObjectExtensionGroup: [AbstractObjectGroup] = []
}
