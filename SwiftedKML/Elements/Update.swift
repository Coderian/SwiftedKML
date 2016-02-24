//
//  Update.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Update
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="Update" type="kml:UpdateType"/>
public class Update :SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "Update"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as NetworkLinkControl: v.value.update = self
                default: break
                }
            }
        }
    }
    public var value : UpdateType = UpdateType()
}
/// KML UpdateType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="UpdateType" final="#all">
///     <sequence>
///     <element ref="kml:targetHref"/>
///     <choice maxOccurs="unbounded">
///     <element ref="kml:Create"/>
///     <element ref="kml:Delete"/>
///     <element ref="kml:Change"/>
///     <element ref="kml:UpdateOpExtensionGroup"/>
///     </choice>
///     <element ref="kml:UpdateExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     </complexType>
///     <element name="UpdateOpExtensionGroup" abstract="true"/>
///     <element name="UpdateExtensionGroup" abstract="true"/>
public class UpdateType {
    public var targetHref : TargetHref!
    public var createOrDeleteOrChange: [AnyObject] = []
    public var updateExtensionGroup: [AnyObject] = []
}
