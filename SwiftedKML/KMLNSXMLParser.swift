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
        switch elementName.lowercaseString {
            // SimpleType
        case Address.elementName.lowercaseString:               return Address()
        case Altitude.elementName.lowercaseString:              return Altitude()
        case AltitudeMode.elementName.lowercaseString:          return AltitudeMode()
        case Begin.elementName.lowercaseString:                 return Begin()
        case BgColor.elementName.lowercaseString:               return BgColor()
        case BottomFov.elementName.lowercaseString:             return BottomFov()
        case Color.elementName.lowercaseString:                 return Color()
        case ColorMode.elementName.lowercaseString:             return ColorMode()
        case Cookie.elementName.lowercaseString:                return Cookie()
        case Coordinates.elementName.lowercaseString:           return Coordinates()
        case Description.elementName.lowercaseString:           return Description()
        case DisplayName.elementName.lowercaseString:           return DisplayName()
        case DisplayMode.elementName.lowercaseString:           return DisplayMode()
        case DrawOrder.elementName.lowercaseString:             return DrawOrder()
        case East.elementName.lowercaseString:                  return East()
        case End.elementName.lowercaseString:                   return End()
        case Expires.elementName.lowercaseString:               return Expires()
        case Extrude.elementName.lowercaseString:               return Extrude()
        case Fill.elementName.lowercaseString:                  return Fill()
        case FlyToView.elementName.lowercaseString:             return FlyToView()
        case GridOrigin.elementName.lowercaseString:            return GridOrigin()
        case Heading.elementName.lowercaseString:               return Heading()
        case Href.elementName.lowercaseString:                  return Href()
        case HttpQuery.elementName.lowercaseString:             return HttpQuery()
        case HotSpot.elementName.lowercaseString:               return HotSpot()
        case Key.elementName.lowercaseString:                   return Key()
        case Latitude.elementName.lowercaseString:              return Latitude()
        case LeftFov.elementName.lowercaseString:               return LeftFov()
        case LinkDescription.elementName.lowercaseString:       return LinkDescription()
        case LinkName.elementName.lowercaseString:              return LinkName()
        case LinkSnippet.elementName.lowercaseString:           return LinkSnippet(attribute: attributes)
        case ListItemType.elementName.lowercaseString:          return ListItemType()
        case Longitude.elementName.lowercaseString:             return Longitude()
        case MaxSnippetLines.elementName.lowercaseString:       return MaxSnippetLines()
        case MaxSessionLength.elementName.lowercaseString:      return MaxSessionLength()
        case Message.elementName.lowercaseString:               return Message()
        case MinAltitude.elementName.lowercaseString:           return MinAltitude()
        case MinFadeExtent.elementName.lowercaseString:         return MinFadeExtent()
        case MinLodPixels.elementName.lowercaseString:          return MinLodPixels()
        case MinRefreshPeriod.elementName.lowercaseString:      return MinRefreshPeriod()
        case MaxAltitude.elementName.lowercaseString:           return MaxAltitude()
        case MaxFadeExtent.elementName.lowercaseString:         return MaxFadeExtent()
        case MaxLodPixels.elementName.lowercaseString:          return MaxLodPixels()
        case MaxHeight.elementName.lowercaseString:             return MaxHeight()
        case MaxWidth.elementName.lowercaseString:              return MaxWidth()
        case Name.elementName.lowercaseString:                  return Name()
        case Near.elementName.lowercaseString:                  return Near()
        case North.elementName.lowercaseString:                 return North()
        case Open.elementName.lowercaseString:                  return Open()
        case Outline.elementName.lowercaseString:               return Outline()
        case OverlayXY.elementName.lowercaseString:             return OverlayXY()
        case PhoneNumber.elementName.lowercaseString:           return PhoneNumber()
        case Range.elementName.lowercaseString:                 return Range()
        case RefreshMode.elementName.lowercaseString:           return RefreshMode()
        case RefreshInterval.elementName.lowercaseString:       return RefreshInterval()
        case RefreshVisibility.elementName.lowercaseString:     return RefreshVisibility()
        case RightFov.elementName.lowercaseString:              return RightFov()
        case Roll.elementName.lowercaseString:                  return Roll()
        case Rotation.elementName.lowercaseString:              return Rotation()
        case RotationXY.elementName.lowercaseString:            return RotationXY()
        case ScreenXY.elementName.lowercaseString:              return ScreenXY()
        case Shape.elementName.lowercaseString:                 return Shape()
        case Size.elementName.lowercaseString:                  return Size()
        case South.elementName.lowercaseString:                 return South()
        case SourceHref.elementName.lowercaseString:            return SourceHref()
        case SnippetString.elementName.lowercaseString:         return SnippetString()
        case State.elementName.lowercaseString:                 return State()
        case StyleUrl.elementName.lowercaseString:              return StyleUrl()
        case TargetHref.elementName.lowercaseString:            return TargetHref()
        case Tessellate.elementName.lowercaseString:            return Tessellate()
        case Text.elementName.lowercaseString:                  return Text()
        case TextColor.elementName.lowercaseString:             return TextColor()
        case TileSize.elementName.lowercaseString:              return TileSize()
        case Tilt.elementName.lowercaseString:                  return Tilt()
        case TopFov.elementName.lowercaseString:                return TopFov()
        case Value.elementName.lowercaseString:                 return Value()
        case ViewBoundScale.elementName.lowercaseString:        return ViewBoundScale()
        case ViewFormat.elementName.lowercaseString:            return ViewFormat()
        case ViewRefreshMode.elementName.lowercaseString:       return ViewRefreshMode()
        case ViewRefreshTime.elementName.lowercaseString:       return ViewRefreshTime()
        case Visibility.elementName.lowercaseString:             return Visibility()
        case West.elementName.lowercaseString:                  return West()
        case When.elementName.lowercaseString:                  return When()
        case Width.elementName.lowercaseString:                 return Width()
        case X.elementName.lowercaseString:                     return X()
        case Y.elementName.lowercaseString:                     return Y()
        case Z.elementName.lowercaseString:                     return Z()
            
            // complexType
        case Alias.elementName.lowercaseString:                 return Alias(attributes: attributes)
        case BalloonStyle.elementName.lowercaseString:          return BalloonStyle(attributes: attributes)
        case OuterBoundaryIs.elementName.lowercaseString:       return OuterBoundaryIs()
        case InnerBoundaryIs.elementName.lowercaseString:       return InnerBoundaryIs()
        case Camera.elementName.lowercaseString:                return Camera(attributes: attributes)
        case Change.elementName.lowercaseString:                return Change()
        case Create.elementName.lowercaseString:                return Create()
        case Data.elementName.lowercaseString:                  return Data(attributes: attributes)
        case Delete.elementName.lowercaseString:                return Delete()
        case Document.elementName.lowercaseString:              return Document(attributes: attributes)
        case ExtendedData.elementName.lowercaseString:          return ExtendedData()
        case Folder.elementName.lowercaseString:                return Folder(attributes: attributes)
        case GroundOverlay.elementName.lowercaseString:         return GroundOverlay(attributes: attributes)
        case IconStyle.elementName.lowercaseString:             return IconStyle(attributes: attributes)
        case ImagePyramid.elementName.lowercaseString:          return ImagePyramid(attributes: attributes)
        case ItemIcon.elementName.lowercaseString:              return ItemIcon(attributes: attributes)
        case Kml.elementName.lowercaseString:                   return Kml(attributes: attributes)
        case LabelStyle.elementName.lowercaseString:            return LabelStyle(attributes: attributes)
        case LatLonAltBox.elementName.lowercaseString:          return LatLonAltBox(attributes: attributes)
        case LatLonBox.elementName.lowercaseString:             return LatLonBox(attributes: attributes)
        case LinearRing.elementName.lowercaseString:            return LinearRing(attributes: attributes)
        case LineString.elementName.lowercaseString:            return LineString(attributes: attributes)
        case LineStyle.elementName.lowercaseString:             return LineStyle(attributes: attributes)
        case Link.elementName.lowercaseString:                  return Link(attributes: attributes)
        case ListStyle.elementName.lowercaseString:             return ListStyle(attributes: attributes)
        case Location.elementName.lowercaseString:              return Location(attributes: attributes)
        case Lod.elementName.lowercaseString:                   return Lod(attributes: attributes)
        case LookAt.elementName.lowercaseString:                return LookAt(attributes: attributes)
        case Metadata.elementName.lowercaseString:              return Metadata()
        case Model.elementName.lowercaseString:                 return Model(attributes: attributes)
        case MultiGeometry.elementName.lowercaseString:         return MultiGeometry(attributes: attributes)
        case NetworkLinkControl.elementName.lowercaseString:    return NetworkLinkControl()
        case NetworkLink.elementName.lowercaseString:           return NetworkLink(attributes: attributes)
        case Orientation.elementName.lowercaseString:           return Orientation(attributes: attributes)
        case Pair.elementName.lowercaseString:                  return Pair(attributes: attributes)
        case PhotoOverlay.elementName.lowercaseString:          return PhotoOverlay(attributes: attributes)
        case Placemark.elementName.lowercaseString:             return Placemark(attributes: attributes)
        case Point.elementName.lowercaseString:                 return Point(attributes: attributes)
        case Polygon.elementName.lowercaseString:               return Polygon(attributes: attributes)
        case PolyStyle.elementName.lowercaseString:             return PolyStyle(attributes: attributes)
        case Region.elementName.lowercaseString:                return Region(attributes: attributes)
        case ResourceMap.elementName.lowercaseString:           return ResourceMap(attributes: attributes)
        case SchemaData.elementName.lowercaseString:            return SchemaData(attributes: attributes)
        case Schema.elementName.lowercaseString:                return Schema(attributes: attributes)
        case ScreenOverlay.elementName.lowercaseString:         return ScreenOverlay(attributes: attributes)
        case SimpleData.elementName.lowercaseString:            return SimpleData(attributes: attributes)
        case SimpleField.elementName.lowercaseString:           return SimpleField(attributes: attributes)
        case SimpleFieldExtension.elementName.lowercaseString:  return SimpleFieldExtension()
        case StyleMap.elementName.lowercaseString:              return StyleMap(attributes: attributes)
        case Style.elementName.lowercaseString:                 return Style(attributes: attributes)
        case TimeSpan.elementName.lowercaseString:              return TimeSpan(attributes: attributes)
        case TimeStamp.elementName.lowercaseString:             return TimeStamp(attributes: attributes)
        case Update.elementName.lowercaseString:                return Update()
        case ViewVolume.elementName.lowercaseString:            return ViewVolume(attributes: attributes)
            
            // 複数あるので特殊処理
        case Scale.elementName.lowercaseString:
            if stack.items.contains({ $0 is Model}) {
                return Model.Scale(attributes: attributes)
            }
            else{
                // case ScaleDouble.elementName.lowercaseString:
                return Scale()
            }
        case IconStyleType.Icon.elementName.lowercaseString:
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
        stack.push(element!)
        debugPrint("OnStart pushd=\(element)")
        isCallEnded = false
        self.contents = ""
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName.uppercaseString == "KML" {
            kml = stack.pop() as? Kml
        }
        else{
            var current = stack.pop()
            debugPrint("OnEnd poped=\(current)")
            if current.dynamicType.elementName == elementName {
                let parent = stack.pop()
                current.parent = parent
                stack.push(parent)
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
//            if stack.count > 0 {
//                let parent = stack.pop()
//                current.parent = parent
//                stack.push(parent)
//            }
        }
        
        stack.push(current)
        
        debugPrint(stack)
    }
    
}