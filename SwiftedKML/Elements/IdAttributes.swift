//
//  IdAttributes.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML idAttributes
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <attributeGroup name="idAttributes">
///     <attribute name="id" type="ID" use="optional"/>
///     <attribute name="targetId" type="NCName" use="optional"/>
///     </attributeGroup>
public class IdAttributes : CustomStringConvertible{
    public var description: String {
        return "id=" + id.value! + ",targetId=" + targetId.value!
    }
    // ID
    public struct ID : XMLAttributed {
        public static var attributeName:String = "id"
        public var value:String?
    }
    public var id: ID = ID()
    // NCName
    public struct NCName: XMLAttributed {
        public static var attributeName:String = "targetId"
        public var value: String?
    }
    public var targetId: NCName = NCName()
    public init(id:String){
        self.id.value = id
    }
    public init(targetId:String){
        self.targetId.value = targetId
    }
    public init(id:String, targetId:String){
        self.id.value = id
        self.targetId.value = targetId
    }
    public init(attributes:[String:String]){
        self.id.value = attributes[ID.attributeName]
        self.targetId.value = attributes[NCName.attributeName]
    }
}
