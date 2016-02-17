//
//  Scale.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Scale
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="scale" type="double" default="1.0"/>
public class Scale: HasXMLElementSimpleValue {
    public static var elementName: String = "scale"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Scale {
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
            case let v as IconStyle:    v.value.scale = self
            case let v as LabelStyle:   v.value.scale = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: Double = 1.0
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = Double(contents)!
        self.parent = parent
        return parent
    }
}

extension Model {
    /// KML Scale
    ///
    /// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
    ///
    ///     <element name="Scale" type="kml:ScaleType" substitutionGroup="kml:AbstractObjectGroup"/>
    public class Scale : AbstractObjectGroup, HasXMLElementValue {
        public static var elementName: String = "Scale"
        public var parent:HasXMLElementName? {
            willSet {
                if newValue == nil {
                    let index = self.parent?.childs.indexOf({
                        if let v = $0 as? Model.Scale {
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
                case let v as Model: v.value.scale = self
                default: break
                }
            }
        }
        public var childs:[HasXMLElementName] = []
        public var attributes:[String:String] = [:]
        public var value : ScaleType
        init(attributes:[String:String]){
            self.value = ScaleType(attributes: attributes)
        }
        public var abstractObject : AbstractObjectType { return self.value }
    }
    /// KML ScaleType
    ///
    /// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
    ///
    ///     <complexType name="ScaleType" final="#all">
    ///     <complexContent>
    ///     <extension base="kml:AbstractObjectType">
    ///     <sequence>
    ///     <element ref="kml:x" minOccurs="0"/>
    ///     <element ref="kml:y" minOccurs="0"/>
    ///     <element ref="kml:z" minOccurs="0"/>
    ///     <element ref="kml:ScaleSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
    ///     <element ref="kml:ScaleObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
    ///     </sequence>
    ///     </extension>
    ///     </complexContent>
    ///     </complexType>
    ///     <element name="ScaleSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
    ///     <element name="ScaleObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
    public class ScaleType : AbstractObjectType {
        public var x: X? // = 1.0
        public var y: Y? // = 1.0
        public var z: Z? // = 1.0
        public var scaleSimpleExtensionGroup: [AnyObject] = []
        public var scaleObjectExtensionGroup: [AbstractObjectGroup] = []
    }
}