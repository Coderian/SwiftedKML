//
//  KMLNSXMLParser.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/04.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Parser of NSXMLParser
class KMLNSXMLParser : NSObject,NSXMLParserDelegate{
    var parser:NSXMLParser!

    private var stack:Stack<HasXMLElementName> = Stack()
    private var isCallEnded:Bool = false
    private var contents:String = ""
    private var previewStackCount:Int = 0
    /// parse結果取得用
    var kml:Kml?
    
    init(Url:NSURL) {
        parser = NSXMLParser(contentsOfURL: Url)
        super.init()
        parser.delegate = self
    }

    // TODO: validate
    func validate() -> Bool {
        return true
    }
    
    func parse() -> Kml?{
        parser.parse()
        return kml
    }
    
    internal func createXMLElement(stack:Stack<HasXMLElementName>, elementName:String,attributes:[String:String]) -> HasXMLElementName? {
        switch elementName {
            // SimpleType
        case Address.elementName:               return Address()
        case Altitude.elementName:              return Altitude()
        case AltitudeMode.elementName:          return AltitudeMode()
        case Begin.elementName:                 return Begin()
        case BgColor.elementName:               return BgColor()
        case BottomFov.elementName:             return BottomFov()
        case Color.elementName:                 return Color()
        case ColorMode.elementName:             return ColorMode()
        case Cookie.elementName:                return Cookie()
        case Coordinates.elementName:           return Coordinates()
        case Description.elementName:           return Description()
        case DisplayName.elementName:           return DisplayName()
        case DisplayMode.elementName:           return DisplayMode()
        case DrawOrder.elementName:             return DrawOrder()
        case East.elementName:                  return East()
        case End.elementName:                   return End()
        case Expires.elementName:               return Expires()
        case Extrude.elementName:               return Extrude()
        case Fill.elementName:                  return Fill()
        case FlyToView.elementName:             return FlyToView()
        case GridOrigin.elementName:            return GridOrigin()
        case Heading.elementName:               return Heading()
        case Href.elementName:                  return Href()
        case HttpQuery.elementName:             return HttpQuery()
        case HotSpot.elementName:               return HotSpot()
        case Key.elementName:                   return Key()
        case Latitude.elementName:              return Latitude()
        case LeftFov.elementName:               return LeftFov()
        case LinkDescription.elementName:       return LinkDescription()
        case LinkName.elementName:              return LinkName()
        case LinkSnippet.elementName:           return LinkSnippet(attribute: attributes)
        case ListItemType.elementName:          return ListItemType()
        case Longitude.elementName:             return Longitude()
        case MaxSnippetLines.elementName:       return MaxSnippetLines()
        case MaxSessionLength.elementName:      return MaxSessionLength()
        case Message.elementName:               return Message()
        case MinAltitude.elementName:           return MinAltitude()
        case MinFadeExtent.elementName:         return MinFadeExtent()
        case MinLodPixels.elementName:          return MinLodPixels()
        case MinRefreshPeriod.elementName:      return MinRefreshPeriod()
        case MaxAltitude.elementName:           return MaxAltitude()
        case MaxFadeExtent.elementName:         return MaxFadeExtent()
        case MaxLodPixels.elementName:          return MaxLodPixels()
        case MaxHeight.elementName:             return MaxHeight()
        case MaxWidth.elementName:              return MaxWidth()
        case Name.elementName:                  return Name()
        case Near.elementName:                  return Near()
        case North.elementName:                 return North()
        case Open.elementName:                  return Open()
        case Outline.elementName:               return Outline()
        case OverlayXY.elementName:             return OverlayXY()
        case PhoneNumber.elementName:           return PhoneNumber()
        case Range.elementName:                 return Range()
        case RefreshMode.elementName:           return RefreshMode()
        case RefreshInterval.elementName:       return RefreshInterval()
        case RefreshVisibility.elementName:     return RefreshVisibility()
        case RightFov.elementName:              return RightFov()
        case Roll.elementName:                  return Roll()
        case Rotation.elementName:              return Rotation()
        case RotationXY.elementName:            return RotationXY()
        case Scale.elementName:                 return Scale()
        case ScreenXY.elementName:              return ScreenXY()
        case Shape.elementName:                 return Shape()
        case Size.elementName:                  return Size()
        case South.elementName:                 return South()
        case SourceHref.elementName:            return SourceHref()
        case SnippetString.elementName:         return SnippetString()
        case State.elementName:                 return State()
        case StyleUrl.elementName:              return StyleUrl()
        case TargetHref.elementName:            return TargetHref()
        case Tessellate.elementName:            return Tessellate()
        case Text.elementName:                  return Text()
        case TextColor.elementName:             return TextColor()
        case TileSize.elementName:              return TileSize()
        case Tilt.elementName:                  return Tilt()
        case TopFov.elementName:                return TopFov()
        case Value.elementName:                 return Value()
        case ViewBoundScale.elementName:        return ViewBoundScale()
        case ViewFormat.elementName:            return ViewFormat()
        case ViewRefreshMode.elementName:       return ViewRefreshMode()
        case ViewRefreshTime.elementName:       return ViewRefreshTime()
        case Visibility.elementName:             return Visibility()
        case West.elementName:                  return West()
        case When.elementName:                  return When()
        case Width.elementName:                 return Width()
        case X.elementName:                     return X()
        case Y.elementName:                     return Y()
        case Z.elementName:                     return Z()
            
            // complexType
        case Alias.elementName:                 return Alias(attributes: attributes)
        case BalloonStyle.elementName:          return BalloonStyle(attributes: attributes)
        case OuterBoundaryIs.elementName:       return OuterBoundaryIs()
        case InnerBoundaryIs.elementName:       return InnerBoundaryIs()
        case Camera.elementName:                return Camera(attributes: attributes)
        case Change.elementName:                return Change()
        case Create.elementName:                return Create()
        case Data.elementName:                  return Data(attributes: attributes)
        case Delete.elementName:                return Delete()
        case Document.elementName:              return Document(attributes: attributes)
        case ExtendedData.elementName:          return ExtendedData()
        case Folder.elementName:                return Folder(attributes: attributes)
        case GroundOverlay.elementName:         return GroundOverlay(attributes: attributes)
        case IconStyle.elementName:             return IconStyle(attributes: attributes)
        case ImagePyramid.elementName:          return ImagePyramid(attributes: attributes)
        case ItemIcon.elementName:              return ItemIcon(attributes: attributes)
        case Kml.elementName:                   return Kml(attributes: attributes)
        case LabelStyle.elementName:            return LabelStyle(attributes: attributes)
        case LatLonAltBox.elementName:          return LatLonAltBox(attributes: attributes)
        case LatLonBox.elementName:             return LatLonBox(attributes: attributes)
        case LinearRing.elementName:            return LinearRing(attributes: attributes)
        case LineString.elementName:            return LineString(attributes: attributes)
        case LineStyle.elementName:             return LineStyle(attributes: attributes)
        case Link.elementName:                  return Link(attributes: attributes)
        case ListStyle.elementName:             return ListStyle(attributes: attributes)
        case Location.elementName:              return Location(attributes: attributes)
        case Lod.elementName:                   return Lod(attributes: attributes)
        case LookAt.elementName:                return LookAt(attributes: attributes)
        case Metadata.elementName:              return Metadata()
        case Model.elementName:                 return Model(attributes: attributes)
        case MultiGeometry.elementName:         return MultiGeometry(attributes: attributes)
        case NetworkLinkControl.elementName:    return NetworkLinkControl()
        case NetworkLink.elementName:           return NetworkLink(attributes: attributes)
        case Orientation.elementName:           return Orientation(attributes: attributes)
        case Pair.elementName:                  return Pair(attributes: attributes)
        case PhotoOverlay.elementName:          return PhotoOverlay(attributes: attributes)
        case Placemark.elementName:             return Placemark(attributes: attributes)
        case Point.elementName:                 return Point(attributes: attributes)
        case Polygon.elementName:               return Polygon(attributes: attributes)
        case PolyStyle.elementName:             return PolyStyle(attributes: attributes)
        case Region.elementName:                return Region(attributes: attributes)
        case ResourceMap.elementName:           return ResourceMap(attributes: attributes)
        case SchemaData.elementName:            return SchemaData(attributes: attributes)
        case Schema.elementName:                return Schema(attributes: attributes)
        case ScreenOverlay.elementName:         return ScreenOverlay(attributes: attributes)
        case SimpleData.elementName:            return SimpleData(attributes: attributes)
        case SimpleField.elementName:           return SimpleField(attributes: attributes)
        case SimpleFieldExtension.elementName:  return SimpleFieldExtension()
        case Snippet.elementName:               return Snippet(attributes: attributes)
        case StyleMap.elementName:              return StyleMap(attributes: attributes)
        case Style.elementName:                 return Style(attributes: attributes)
        case TimeSpan.elementName:              return TimeSpan(attributes: attributes)
        case TimeStamp.elementName:             return TimeStamp(attributes: attributes)
        case Update.elementName:                return Update()
        case ViewVolume.elementName:            return ViewVolume(attributes: attributes)
        case Model.Scale.elementName:           return Model.Scale(attributes: attributes)
            // 複数あるので特殊処理
        case IconStyleType.Icon.elementName:
            if stack.items.contains({ $0 is IconStyle}){
                return IconStyleType.Icon()
            }
            else{
                // case Icon.elementName.lowercaseString:
                return Icon(attributes: attributes)
            }
        default:                                                return nil
        }
    }
    
    // MARK: NSXMLParserDelegate
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        let element = createXMLElement(stack,elementName: elementName,attributes: attributeDict)
        if element == nil {
            return
        }
        stack.push(element!)
        debugPrint("OnStart pushd=\(element)")
        isCallEnded = false
        self.contents = ""
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == Kml.elementName {
            kml = stack.pop() as? Kml
        }
        else{
            var current = stack.pop()
            debugPrint("OnEnd poped=\(current) == \(elementName)")
            if current.dynamicType.elementName == elementName {
                let parent = stack.pop()
                current.parent = parent
                stack.push(parent)
            }
            else {
                stack.push(current)
            }
        }
        isCallEnded = true
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        debugPrint("OnCharacters isCallEnded=\(isCallEnded)")
        if isCallEnded {
            return
        }
        // contentsが長い文字列の場合は複数回呼ばれるので対応が必要
        if self.previewStackCount == stack.count {
            self.contents += string
        }
        else{
            self.contents = string
        }
        
        self.previewStackCount = stack.count
        let current = stack.pop()
        debugPrint("poped=\(current) contents=\(contents)")
        debugPrint("self.contents=\(self.contents)")
        
        switch current {
        case let v as Address:          stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Altitude:         stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as AltitudeMode:     stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Begin:            stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as BgColor:          stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as BottomFov:        stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Color:            stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as ColorMode:        stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Cookie:           stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Coordinates:      stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Description:      stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as DisplayName:      stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as DisplayMode:      stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as DrawOrder:        stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as East:             stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as End:              stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Expires:          stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Extrude:          stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Fill:             stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as FlyToView:        stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as GridOrigin:       stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Heading:          stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Href:             stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as HttpQuery:        stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Key:              stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Latitude:         stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as LeftFov:          stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as LinkDescription:  stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as LinkName:         stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as LinkSnippet:      stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as ListItemType:     stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Longitude:        stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as MaxSnippetLines:  stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as MaxSessionLength: stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Message:          stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as MinAltitude:      stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as MinFadeExtent:    stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as MinRefreshPeriod: stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as MaxAltitude:      stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as MaxFadeExtent:    stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as MaxLodPixels:     stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as MaxHeight:        stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as MaxWidth:         stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Name:             stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Near:             stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as North:            stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Open:             stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Outline:          stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as PhoneNumber:      stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as RefreshMode:      stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as RefreshInterval:  stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as RefreshVisibility:stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as RightFov:         stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Roll:             stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Rotation:         stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Scale:            stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Shape:            stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as South:            stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as SourceHref:       stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as SnippetString:    stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as State:            stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as StyleUrl:         stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as TargetHref:       stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Tessellate:       stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Text:             stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as TextColor:        stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as TileSize:         stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Tilt:             stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as TopFov:           stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Value:            stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as ViewBoundScale:   stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as ViewFormat:       stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as ViewRefreshMode:  stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as ViewRefreshTime:  stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Visibility:       stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as West:             stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as When:             stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Width:            stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as X:                stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Y:                stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Z:                stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        default:                        break
        }
        
        stack.push(current)
        
        debugPrint(stack)
    }
    
}