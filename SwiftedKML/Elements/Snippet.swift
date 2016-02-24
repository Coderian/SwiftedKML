//
//  Snippet.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

typealias SnippetDeprecated = SnippetType
/// KML Snippet
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Snippet" type="kml:SnippetType"/>
public class Snippet :SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "Snippet"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                    
                default: break
                }
            }
        }
    }
    public var value: SnippetType
    public required init(attributes:[String:String]){
        self.value = SnippetType(attributes: attributes)
        super.init(attributes: attributes)
    }
}
/// KML SnippetType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="SnippetType" final="#all">
///     <simpleContent>
///     <extension base="string">
///     <attribute name="maxLines" type="int" use="optional" default="2"/>
///     </extension>
///     </simpleContent>
///     </complexType>
public class SnippetType {
    public var value: String = ""
    public struct MaxLines : XMLAttributed {
        public static var attributeName: String = "maxLines"
        public var value : Int = 2
        init(value:String){
            self.value = Int(value)!
        }
    }
    public var maxLines: MaxLines!
    init(attributes:[String:String]){
        if let v = attributes[MaxLines.attributeName] {
            self.maxLines = MaxLines(value: v)
        }
    }
}
