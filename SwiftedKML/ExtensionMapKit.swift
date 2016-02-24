//
//  ExtensionMapKit.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/23.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation
import MapKit
import UIKit

/// MapKit 用の値に変換するextension

extension Style {
    // TODO:LineStyle
    // TODO:PolyStyle
    // TODO:Width
}

extension Placemark {
    // MKOverlay
    var toMKOverlay:MKOverlay? {
        var shape:MKShape? = nil
        let polygons = self.select(Polygon)
        if polygons.count == 1 {
            let polygon = polygons[0].toMKPolygon
            shape = polygon
            shape?.title = self.value.name?.value
        }
        return shape as? MKOverlay
    }
    // MKOverlayPathRenderer
    func getMKOverlayPathRenderer() -> MKOverlayPathRenderer? {
        let polygons = self.select(Polygon)
        if polygons.count == 1 {
            let idString = self.value.styleUrl?.value.substringFromIndex(self.value.styleUrl!.value.startIndex.advancedBy(1))
            debugPrint("id = \(idString)")
            let styles = self.root.select("id", attributeValue: idString!)
            debugPrint("\(styles)")
            let renderer = polygons[0].getMKOverlayPathRenderer()!
            if styles.count == 1 {
                let style = styles[0] as! Style
                renderer.strokeColor = style.value.lineStyle?.value.color?.toUIColor
                renderer.fillColor = style.value.polyStyle?.value.color?.toUIColor
                renderer.lineWidth = CGFloat((style.value.lineStyle?.value.width?.value)!)
            }
            return renderer
        }
        return nil
    }
    // MKAnnotation
    var toMKAnnotation:MKAnnotation? {
        let points = self.select(Point)
        if points.count == 1 {
            let point = points[0].toMKPointAnnotation
            point?.title = self.value.name?.value
            return point
        }
        return nil
    }
    // MKAnnotationView
    func getMKAnnotationView() -> MKAnnotationView? {
        let points = self.select(Point)
        if points.count == 1 {
            return points[0].getMKAnnotationView()
        }
        return nil
    }
}

extension Point {
    // MKPointAnnotation
    var toMKPointAnnotation:MKPointAnnotation? {
        guard let coordinate = (self.value.coordinates?.toLocationCoordinate2Ds[0]) else {
            return nil
        }
        let anotation:MKPointAnnotation = MKPointAnnotation()
        anotation.coordinate = coordinate
        return anotation
    }
    
    //
    func getMKAnnotationView() -> MKAnnotationView? {
        guard let point = self.toMKPointAnnotation else {
            return nil
        }
        let view = MKPinAnnotationView(annotation: point, reuseIdentifier: nil)
        view.canShowCallout = true
        view.animatesDrop = true
        return view
    }
}

extension Polygon {
    // MKPolygon
    var toMKPolygon:MKPolygon? {
        let coords:[CLLocationCoordinate2D] = self.value.outerBoundaryIs!.value.linearRing!.value.coordinates!.toLocationCoordinate2Ds
        var polygons:[MKPolygon] = []
        if var innerBoundaryIsCoord:[CLLocationCoordinate2D] = self.value.innerBoundaryIs?.value.linearRing?.value.coordinates?.toLocationCoordinate2Ds {
            polygons.append(MKPolygon(coordinates: &innerBoundaryIsCoord, count: innerBoundaryIsCoord.count))
        }
        let ret = MKPolygon(coordinates: UnsafeMutablePointer<CLLocationCoordinate2D>(coords), count: coords.count, interiorPolygons: polygons)
        debugPrint("\(ret.pointCount) == \(coords.count)")
        assert(ret.pointCount == coords.count)
        return ret
    }
    // MKOverlayPathRenderer
    func getMKOverlayPathRenderer() -> MKOverlayPathRenderer? {
        guard let polygon = self.toMKPolygon else {
            return nil
        }
        let renderer = MKPolygonRenderer(polygon: polygon)
        return renderer
    }
}

extension LineString {
    // MKShape
    var toMKPolyLine:MKPolyline? {
        let coords:[CLLocationCoordinate2D] = self.value.coordinates!.toLocationCoordinate2Ds
        let ret = MKPolyline(coordinates: UnsafeMutablePointer<CLLocationCoordinate2D>(coords), count: coords.count)
        return ret
    }
    // KMOverlayPathRenderer
    func getMKOverlayPathRenderer(target: MKPolyline) -> MKOverlayPathRenderer? {
        let renderer = MKPolylineRenderer(polyline: target)
        return renderer
    }
}

extension Coordinates {
    var toLocationCoordinate2Ds:[CLLocationCoordinate2D] {
        var ret:[CLLocationCoordinate2D]=[]
        ret.reserveCapacity(10)
        for v in value {
            let longitude:Double = Double(v.longitude)!
            let latitude:Double = Double(v.latitude)!
            let coord = CLLocationCoordinate2DMake(latitude, longitude)
            if CLLocationCoordinate2DIsValid(coord) {
                ret.append(coord)
            }
        }
        return ret
    }
}



extension BgColor {
    var toUIColor:UIColor? {
        return UIColor(hexString: self.value)
    }
}

extension Color {
    var toUIColor:UIColor? {
        return UIColor(hexString: self.value)
    }
}

extension TextColor {
    var toUIColor:UIColor? {
        return UIColor(hexString: self.value)
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
