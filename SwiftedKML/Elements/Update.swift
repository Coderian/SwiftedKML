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
public class Update : HasXMLElementValue {
    public static var elementName: String = "Update"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Update {
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
            case let v as NetworkLinkControl: v.value.update = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
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
    public var targetHref : TargetHref?
    public var createOrDeleteOrChange: [AnyObject] = []
    public var updateExtensionGroup: [AnyObject] = []
}
