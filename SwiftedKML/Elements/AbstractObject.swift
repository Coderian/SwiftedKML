//
//  AbstractObject.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML AbstractObjectGroup
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="AbstractObjectGroup" type="kml:AbstractObjectType" abstract="true"/>
public protocol AbstractObjectGroup {
    var abstractObject : AbstractObjectType { get }
}
/// KML AbstractObjectType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="AbstractObjectType" abstract="true">
///     <sequence>
///     <element ref="kml:ObjectSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     <attributeGroup ref="kml:idAttributes"/>
///     </complexType>
///     <element name="ObjectSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
public class AbstractObjectType {
    public var objectSimpleExtensionGroup: [AnyObject] = []
    public var attribute: IdAttributes!
    public init(){}
    public init(attributes:[String:String]){
        self.attribute = IdAttributes(attributes: attributes)
    }
}
