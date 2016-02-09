//
//  Folder.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Folder
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Folder" type="kml:FolderType" substitutionGroup="kml:AbstractContainerGroup"/>
public class Folder : AbstractContainerGroup, HasXMLElementValue {
    public static var elementName: String = "Folder"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Folder {
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
            case let v as Document: v.value.abstractFeatureGroup.append(self)
            case let v as Folder:   v.value.abstractFeatureGroup.append(self)
            case let v as Create:   v.value.abstractContainerGroup.append(self)
            case let v as Delete:   v.value.abstractFeatureGroup.append(self)
            case let v as Kml:      v.value.abstractFeatureGroup = self
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
    public var value : FolderType
    init(attributes:[String:String]){
        self.value = FolderType(attributes: attributes)
    }
    public var abstractObject : AbstractObjectType { return self.value }
    public var abstractFeature : AbstractFeatureType{ return self.value }
    public var abstractContainer : AbstractContainerType { return self.value }
}
/// KML FolderType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
// <complexType name="FolderType" final="#all">
// <complexContent>
// <extension base="kml:AbstractContainerType">
// <sequence>
// <element ref="kml:AbstractFeatureGroup" minOccurs="0" maxOccurs="unbounded"/>
// <element ref="kml:FolderSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
// <element ref="kml:FolderObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
// </sequence>
// </extension>
// </complexContent>
// </complexType>
// <element name="FolderSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
// <element name="FolderObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class FolderType: AbstractContainerType {
    public var abstractFeatureGroup:[AbstractFeatureGroup] = []
    public var folderSimpleExtensionGroup: [AnyObject] = []
    public var folderObjectExtensionGroup: [AbstractObjectGroup] = []
}
