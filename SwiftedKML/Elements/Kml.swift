//
//  Kml.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML kml
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <element name="kml" type="kml:KmlType">
///     <annotation>
///     <documentation><![CDATA[
///
///         <kml> is the root element.
///
///         ]]></documentation>
///     </annotation>
///     </element>
public class Kml :SPXMLElement, XMLElementRoot, HasXMLElementValue , CustomStringConvertible{
    public static var elementName: String = "kml"
    public var value : KmlType = KmlType()
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }

    public static var creaters:[String:SPXMLElement.Type] = [
        Address.elementName:                Address.self,
        Altitude.elementName:               Altitude.self,
        AltitudeMode.elementName:           AltitudeMode.self,
        Begin.elementName:                  Begin.self,
        BgColor.elementName:                BgColor.self,
        BottomFov.elementName:              BottomFov.self,
        Color.elementName:                  Color.self,
        ColorMode.elementName:              ColorMode.self,
        Cookie.elementName:                 Cookie.self,
        Coordinates.elementName:            Coordinates.self,
        Description.elementName:            Description.self,
        DisplayName.elementName:            DisplayName.self,
        DisplayMode.elementName:            DisplayMode.self,
        DrawOrder.elementName:              DrawOrder.self,
        East.elementName:                   East.self,
        End.elementName:                    End.self,
        Expires.elementName:                Expires.self,
        Extrude.elementName:                Extrude.self,
        Fill.elementName:                   Fill.self,
        FlyToView.elementName:              FlyToView.self,
        GridOrigin.elementName:             GridOrigin.self,
        Heading.elementName:                Heading.self,
        Href.elementName:                   Href.self,
        HttpQuery.elementName:              HttpQuery.self,
        HotSpot.elementName:                HotSpot.self,
        Key.elementName:                    Key.self,
        Latitude.elementName:               Latitude.self,
        LeftFov.elementName:                LeftFov.self,
        LinkDescription.elementName:        LinkDescription.self,
        LinkName.elementName:               LinkName.self,
        LinkSnippet.elementName:            LinkSnippet.self,
        ListItemType.elementName:           ListItemType.self,
        Longitude.elementName:              Longitude.self,
        MaxSnippetLines.elementName:        MaxSnippetLines.self,
        MaxSessionLength.elementName:       MaxSessionLength.self,
        Message.elementName:                Message.self,
        MinAltitude.elementName:            MinAltitude.self,
        MinFadeExtent.elementName:          MinFadeExtent.self,
        MinLodPixels.elementName:           MinLodPixels.self,
        MinRefreshPeriod.elementName:       MinRefreshPeriod.self,
        MaxAltitude.elementName:            MaxAltitude.self,
        MaxFadeExtent.elementName:          MaxFadeExtent.self,
        MaxLodPixels.elementName:           MaxLodPixels.self,
        MaxHeight.elementName:              MaxHeight.self,
        MaxWidth.elementName:               MaxWidth.self,
        Name.elementName:                   Name.self,
        Near.elementName:                   Near.self,
        North.elementName:                  North.self,
        Open.elementName:                   Open.self,
        Outline.elementName:                Outline.self,
        OverlayXY.elementName:              OverlayXY.self,
        PhoneNumber.elementName:            PhoneNumber.self,
        Range.elementName:                  Range.self,
        RefreshMode.elementName:            RefreshMode.self,
        RefreshInterval.elementName:        RefreshInterval.self,
        RefreshVisibility.elementName:      RefreshVisibility.self,
        RightFov.elementName:               RightFov.self,
        Roll.elementName:                   Roll.self,
        Rotation.elementName:               Rotation.self,
        RotationXY.elementName:             RotationXY.self,
        Scale.elementName:                  Scale.self,
        ScreenXY.elementName:               ScreenXY.self,
        Shape.elementName:                  Shape.self,
        Size.elementName:                   Size.self,
        South.elementName:                  South.self,
        SourceHref.elementName:             SourceHref.self,
        SnippetString.elementName:          SnippetString.self,
        State.elementName:                  State.self,
        StyleUrl.elementName:               StyleUrl.self,
        TargetHref.elementName:             TargetHref.self,
        Tessellate.elementName:             Tessellate.self,
        Text.elementName:                   Text.self,
        TextColor.elementName:              TextColor.self,
        TileSize.elementName:               TileSize.self,
        Tilt.elementName:                   Tilt.self,
        TopFov.elementName:                 TopFov.self,
        Value.elementName:                  Value.self,
        ViewBoundScale.elementName:         ViewBoundScale.self,
        ViewFormat.elementName:             ViewFormat.self,
        ViewRefreshMode.elementName:        ViewRefreshMode.self,
        ViewRefreshTime.elementName:        ViewRefreshTime.self,
        Visibility.elementName:              Visibility.self,
        West.elementName:                   West.self,
        When.elementName:                   When.self,
        Width.elementName:                  Width.self,
        X.elementName:                      X.self,
        Y.elementName:                      Y.self,
        Z.elementName:                      Z.self,
        
        // complexType
        Alias.elementName:                  Alias.self,
        BalloonStyle.elementName:           BalloonStyle.self,
        OuterBoundaryIs.elementName:        OuterBoundaryIs.self,
        InnerBoundaryIs.elementName:        InnerBoundaryIs.self,
        Camera.elementName:                 Camera.self,
        Change.elementName:                 Change.self,
        Create.elementName:                 Create.self,
        Data.elementName:                   Data.self,
        Delete.elementName:                 Delete.self,
        Document.elementName:               Document.self,
        ExtendedData.elementName:           ExtendedData.self,
        Folder.elementName:                 Folder.self,
        GroundOverlay.elementName:          GroundOverlay.self,
        IconStyle.elementName:              IconStyle.self,
        ImagePyramid.elementName:           ImagePyramid.self,
        ItemIcon.elementName:               ItemIcon.self,
        Kml.elementName:                    Kml.self,
        LabelStyle.elementName:             LabelStyle.self,
        LatLonAltBox.elementName:           LatLonAltBox.self,
        LatLonBox.elementName:              LatLonBox.self,
        LinearRing.elementName:             LinearRing.self,
        LineString.elementName:             LineString.self,
        LineStyle.elementName:              LineStyle.self,
        Link.elementName:                   Link.self,
        ListStyle.elementName:              ListStyle.self,
        Location.elementName:               Location.self,
        Lod.elementName:                    Lod.self,
        LookAt.elementName:                 LookAt.self,
        Metadata.elementName:               Metadata.self,
        Model.elementName:                  Model.self,
        MultiGeometry.elementName:          MultiGeometry.self,
        NetworkLinkControl.elementName:     NetworkLinkControl.self,
        NetworkLink.elementName:            NetworkLink.self,
        Orientation.elementName:            Orientation.self,
        Pair.elementName:                   Pair.self,
        PhotoOverlay.elementName:           PhotoOverlay.self,
        Placemark.elementName:              Placemark.self,
        Point.elementName:                  Point.self,
        Polygon.elementName:                Polygon.self,
        PolyStyle.elementName:              PolyStyle.self,
        Region.elementName:                 Region.self,
        ResourceMap.elementName:            ResourceMap.self,
        SchemaData.elementName:             SchemaData.self,
        Schema.elementName:                 Schema.self,
        ScreenOverlay.elementName:          ScreenOverlay.self,
        SimpleData.elementName:             SimpleData.self,
        SimpleField.elementName:            SimpleField.self,
        SimpleFieldExtension.elementName:   SimpleFieldExtension.self,
        Snippet.elementName:                Snippet.self,
        StyleMap.elementName:               StyleMap.self,
        Style.elementName:                  Style.self,
        TimeSpan.elementName:               TimeSpan.self,
        TimeStamp.elementName:              TimeStamp.self,
        Update.elementName:                 Update.self,
        ViewVolume.elementName:             ViewVolume.self,
        Model.Scale.elementName:            Model.Scale.self
    ]
    
    public static func createElement(elementName:String, attributes:[String:String], stack:Stack<SPXMLElement>) -> SPXMLElement? {
        // 複数あるので特殊処理
        if elementName == IconStyleType.Icon.elementName {
            if stack.items.contains({ $0 is IconStyle}){
                return IconStyleType.Icon()
            }
            else{
                // case Icon.elementName.lowercaseString:
                return Icon(attributes: attributes)
            }
        }
        return creaters[elementName]?.init(attributes:attributes)
    }
}

/// KML KmlType
///
/// [KML 2.2 shcema](http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd)
///
///     <complexType name="KmlType" final="#all">
///     <sequence>
///     <element ref="kml:NetworkLinkControl" minOccurs="0"/>
///     <element ref="kml:AbstractFeatureGroup" minOccurs="0"/>
///     <element ref="kml:KmlSimpleExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     <element ref="kml:KmlObjectExtensionGroup" minOccurs="0" maxOccurs="unbounded"/>
///     </sequence>
///     <attribute name="hint" type="string"/>
///     </complexType>
///     <element name="KmlSimpleExtensionGroup" abstract="true" type="anySimpleType"/>
///     <element name="KmlObjectExtensionGroup" abstract="true" substitutionGroup="kml:AbstractObjectGroup"/>
public class KmlType {
    public var networkLinkControl: NetworkLinkControl!
    public var abstractFeatureGroup: AbstractFeatureGroup!
    public var kmlSimpleExtensionGroup: [AnyObject] = []
    public var kmlObjectExtensionGroup: [AbstractObjectGroup] = []
    public struct Hint : XMLAttributed {
        public static var attributeName: String = "hint"
        public var value: String = ""
    }
    public var hint: Hint!
}

