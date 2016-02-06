//
//  SwiftedKMLTests.swift
//  SwiftedKMLTests
//
//  Created by 佐々木 均 on 2016/02/04.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import XCTest
@testable import SwiftedKML

class SwiftedKMLTests: XCTestCase {
    let bundle = NSBundle(forClass: SwiftedKMLTests.self)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_KML_Sample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let kmlXmlUrl = bundle.URLForResource("KML_Sample", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        let childs = kml?.allChilds()
        print(childs)
        let namestype = kml?.select(Name)
        for n in namestype! {
            print(n.value)
        }
        let placemarks = kml?.select(Placemark)
        for p in placemarks! {
            let points = p.select(SwiftedKML.Point)
            if points.isEmpty == false {
                print(p.value.name?.value)
            }
            for pt in points {
                print(pt.value) // TODO:MKAnnotation
                print("MKAnnotation \(pt.value.coordinates?.locationCoordinates)")
            }
            for plg in p.select(SwiftedKML.Polygon){
                print(p.value.name?.value)
                print(plg.value.innerBoundaryIs?.value.linearRing?.value.coordinates)
                print(plg.value.outerBoundaryIs?.value.linearRing?.value.coordinates) // TODO:MKOverlay
                print("MKOverlay \(plg.value.outerBoundaryIs?.value.linearRing?.value.coordinates?.locationCoordinates)")
                print("poly = \(plg.polygon)")
            }
        }
        
    }
    
    func test_mackynormal() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("macky-normal", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        let childs = kml?.allChilds()
        XCTAssert(childs?.count == 28 + 20 + 20 + 20 ,"failre all element count")
        let placemarks = kml?.select(Placemark)
        XCTAssert(placemarks?.count == 1, "failre placemark count")
        let names = kml?.select(Name)
        XCTAssert(names?.count == 1, "failre name count")
        let descriptions = kml?.select(Description)
        XCTAssert(descriptions!.count == 1, "failre description count")
        let lookAts = kml?.select(LookAt)
        XCTAssert(lookAts!.count == 1, "failre lookAt count")
        let longitudes = kml?.select(Longitude)
        XCTAssert(longitudes?.count == 2)
        let latitudes = kml?.select(Latitude)
        XCTAssert(latitudes?.count == 2)
        let altitudes = kml?.select(Altitude)
        XCTAssert(altitudes?.count == 2)
        let renges = kml?.select(SwiftedKML.Range)
        XCTAssert(renges?.count == 1)
        let tilts = kml?.select(Tilt)
        XCTAssert(tilts?.count == 2)
        let headings = kml?.select(Heading)
        XCTAssert(headings?.count == 2)
        let models = kml?.select(Model)
        XCTAssert(models?.count == 1)
        let altitudeModes = kml?.select(AltitudeMode)
        XCTAssert(altitudeModes?.count == 1)
        let locations = kml?.select(Location)
        XCTAssert(locations?.count == 1)
        let orientations = kml?.select(Orientation)
        XCTAssert(orientations?.count == 1)
        let rolls = kml?.select(Roll)
        XCTAssert(rolls?.count == 1)
        // TODO:why?... Expected member name or constructor call after type name
//        let scales = kml?.select(Model.Scale)
//        XCTAssert(scales?.count == 1)
        XCTAssertNotNil(models?[0].value.scale)
        let links = kml?.select(Link)
        XCTAssert(links?.count == 1)
        let alias = kml?.select(Alias)
        XCTAssert(alias?.count == 20, "failre alias count")
    }
    
    func test_sharedtextures() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("shared-textures", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    
    func test_spaceneedle() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("space-needle", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    
    func test_checkoffonly() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("check-off-only", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    
    func test_itemiconhotspot() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("item-icon-hotspot", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    
    func test_polygonfade() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("polygon-fade", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    
    func test_polygonminmax() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("polygon-min-max", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    
    func test_polygonsimple() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("polygon-simple", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    func test_polygonswapfade() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("polygon-swap-fade", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    func test_polygonswappop() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("polygon-swap-pop", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    func test_radiofolder() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("radio-folder", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    func test_radiohidechildren() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("radio-hide-children", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    func test_timeinherits() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("time-inherits", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    func test_timespanoverlay() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("time-span-overlay", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    func test_timestamppoint() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("time-stamp-point", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    func test_usacasf() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("usa-ca-sf", withExtension: "kml")
        let kmlParser = KMLNSXMLParser(Url: kmlXmlUrl!)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
