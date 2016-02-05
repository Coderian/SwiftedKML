//
//  Color.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation
import UIKit

/// KML Color
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="color" type="kml:colorType" default="ffffffff"/>
public class Color:HasXMLElementSimpleValue {
    public static var elementName:String = "color"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Color {
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
            case let v as BalloonStyle: v.value.color = self
            case let v as IconStyle:    v.value.color = self
            case let v as LabelStyle:   v.value.color = self
            case let v as LineStyle:    v.value.color = self
            case let v as PolyStyle:    v.value.color = self
            case let v as PhotoOverlay :v.value.color = self
            case let v as ScreenOverlay:v.value.color = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var value: UIColor = UIColor(hexString: "ffffffff")!
    init(){}
    init( valueHexString : String){
        self.value = UIColor(hexString: valueHexString)!
    }
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = UIColor(hexString: contents)!
        self.parent = parent
        return parent
    }
}

/// <summary>
/// <![CDATA[
///
///        aabbggrr
///
///        ffffffff: opaque white
///        ff000000: opaque black
///
///        ]]>
/// </summary>
public extension UIColor {
    public convenience init?(hexString: String){
        let r, g, b, a : CGFloat
        if hexString.characters.count == 8 {
            let scanner = NSScanner(string: hexString)
            var hexNumber: UInt64 = 0
            if scanner.scanHexLongLong(&hexNumber) {
                a = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                b = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                r = CGFloat(hexNumber & 0x000000ff) / 255
                self.init(red:r, green: g, blue: b, alpha: a)
                return
            }
        }
        return nil
    }
    func toHexString() -> String {
        // TODO: hexString
        return ""
    }
}
// <simpleType name="colorType">
// <annotation>
// <documentation><![CDATA[
//
//    aabbggrr
//
//    ffffffff: opaque white
//    ff000000: opaque black
//
//    ]]></documentation>
// </annotation>
// <restriction base="hexBinary">
// <length value="4"/>
// </restriction>
// </simpleType>
public class colorType : UIColor {
}

