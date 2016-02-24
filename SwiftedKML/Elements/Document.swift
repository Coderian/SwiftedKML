//
//  Document.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Document
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Document" type="kml:DocumentType" substitutionGroup="kml:AbstractContainerGroup"/>
public class Document : SPXMLElement, AbstractContainerGroup , HasXMLElementValue{
    public static var elementName : String = "Document"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as Kml:      v.value.abstractFeatureGroup = self
                case let v as Folder:   v.value.abstractFeatureGroup.append(self)
                case let v as Create:   v.value.abstractContainerGroup.append(self)
                case let v as Document: v.value.abstractFeatureGroup.append(self)
                case let v as Delete:   v.value.abstractFeatureGroup.append(self)
                default: break
                }
            }
        }
    }
    public var value : DocumentType
    required public init(attributes:[String:String]){
        self.value = DocumentType(attributes: attributes)
        super.init(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractFeature : AbstractFeatureType{ return self.value }
    public var abstractContainer : AbstractContainerType { return self.value }
}
/// KML DocumentType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="DocumentType" final="#all">
///     <complexContent>
///     <extension base="kml:AbstractContainerType">
///     <sequence>
///     <element ref="kml:Schema" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:AbstractFeatureGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:DocumentSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:DocumentObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </extension>
///     </complexContent>
///     </complexType>
///     <element name="DocumentSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="DocumentObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class DocumentType: AbstractContainerType {
    public var schema:[Schema] = []
    public var abstractFeatureGroup:[AbstractFeatureGroup] = []
    public var documentSimpleExtensionGroup: [AnyObject] = []
    public var documentObjectExtensionGroup: [AbstractObjectGroup] = []
}
