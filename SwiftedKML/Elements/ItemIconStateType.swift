//
//  ItemIconStateType.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML ItemIconStateEnumType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <simpleType name="itemIconStateEnumType">
///     <restriction base="string">
///     <enumeration value="open"/>
///     <enumeration value="closed"/>
///     <enumeration value="error"/>
///     <enumeration value="fetching0"/>
///     <enumeration value="fetching1"/>
///     <enumeration value="fetching2"/>
///     </restriction>
///     </simpleType>
public enum ItemIconStateEnumType:String {
    case Open="open", Closed="closed", Error="error", Fetching0="fetching0", Fetching1="fetching1", Fetching2="fetching2"
}
/// KML ItemIconStateType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <simpleType name="itemIconStateType">
///     <list itemType="kml:itemIconStateEnumType"/>
///     </simpleType>
public class ItemIconStateType {
    var itemType:[ItemIconStateEnumType] = []
}
