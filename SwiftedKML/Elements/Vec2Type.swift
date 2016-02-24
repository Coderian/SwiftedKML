//
//  Vec2Type.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML UnitsEnumType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <simpleType name="unitsEnumType">
///     <restriction base="string">
///     <enumeration value="fraction"/>
///     <enumeration value="pixels"/>
///     <enumeration value="insetPixels"/>
///     </restriction>
///     </simpleType>
public enum UnitsEnumType:String {
    case Fraction="fraction", Pixels="pixels", IinsetPixels="insetPixels"
}
/// KML Vec2Type
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="vec2Type" abstract="false">
///     <attribute name="x" type="double" default="1.0"/>
///     <attribute name="y" type="double" default="1.0"/>
///     <attribute name="xunits" type="kml:unitsEnumType" use="optional" default="fraction"/>
///     <attribute name="yunits" type="kml:unitsEnumType" use="optional" default="fraction"/>
///     </complexType>
public class Vec2Type {
    public struct X : XMLAttributed {
        public static var attributeName: String = "x"
        public var value: Double = 1.0
    }
    public var x: X = X() // = 1.0
    public struct Y : XMLAttributed {
        public static var attributeName:String = "y"
        public var value : Double = 1.0
    }
    public var y: Y = Y() // = 1.0
    public struct XUnits:XMLAttributed {
        public static var attributeName: String = "xunits"
        public var value : UnitsEnumType = .Fraction
    }
    public var xunits: XUnits = XUnits() // = .Fraction
    public struct YUnits:XMLAttributed {
        public static var attributeName: String = "yunits"
        public var value : UnitsEnumType = .Fraction
    }
    public var yunits: YUnits = YUnits() // = .Fraction
    public init(){}
    public init(attributes:[String:String]){
        self.x.value = Double(attributes[X.attributeName]!)!
        self.y.value = Double(attributes[Y.attributeName]!)!
        self.xunits.value = UnitsEnumType(rawValue: attributes[XUnits.attributeName]!)!
        self.yunits.value = UnitsEnumType(rawValue: attributes[YUnits.attributeName]!)!
    }
}
