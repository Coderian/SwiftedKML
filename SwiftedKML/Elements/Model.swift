//
//  Model.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Model
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Model" type="kml:ModelType" substitutionGroup="kml:AbstractGeometryGroup"/>
public class Model : AbstractGeometryGroup, HasXMLElementValue {
    public static var elementName: String = "Model"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Model {
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
            case let v as MultiGeometry:v.value.abstractGeometryGroup.append(self)
            case let v as Placemark:    v.value.abstractGeometryGroup = self
            default: break
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
    public var value : ModelType
    public init(attributes:[String:String]){
        self.value = ModelType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractGeometry : AbstractGeometryType { return self.value }
}
/// KML ModelType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="ModelType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractGeometryType">
///     <sequence>
///     <element ref="kml:altitudeModeGroup" minOccurs="0"/>
///     <element ref="kml:Location" minOccurs="0"/>
///     <element ref="kml:Orientation" minOccurs="0"/>
///     <element ref="kml:Scale" minOccurs="0"/>
///     <element ref="kml:Link" minOccurs="0"/>
///     <element ref="kml:ResourceMap" minOccurs="0"/>
///     <element ref="kml:ModelSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:ModelObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="ModelSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="ModelObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class ModelType: AbstractGeometryType {
    public var altitudeModeGroup : AltitudeModeGroup?
    public var location: Location?
    public var orientation: Orientation?
    public var scale: Model.Scale?
    public var link: Link?
    public var resourceMap: ResourceMap?
    public var modelSimpleExtensionGroup: [AnyObject] = []
    public var modelObjectExtensionGroup: [AbstractObjectGroup] = []
}
