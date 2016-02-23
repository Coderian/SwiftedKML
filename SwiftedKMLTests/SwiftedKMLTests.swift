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
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root: Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある")
        print(kmlParser.unSupported)
        let childs = kml?.allChilds()
        print(childs)
        let root = kml?.root
        XCTAssert(root is Kml)
        let rootfromChild = kml?.childs.first!.root
        XCTAssert(rootfromChild is Kml)
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
        
        let styles = kml?.select("id", attributeValue: "downArrowIcon")
        XCTAssert(styles?.count == 1)
        XCTAssert(styles![0].root === kml,"root 間違い")
        print(styles)
        
    }
    
    func test_mackynormal() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("macky-normal", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
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
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    
    func test_spaceneedle() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("space-needle", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    
    func test_checkoffonly() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("check-off-only", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    
    func test_itemiconhotspot() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("item-icon-hotspot", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    
    func test_polygonfade() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("polygon-fade", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    
    func test_polygonminmax() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("polygon-min-max", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    
    func test_polygonsimple() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("polygon-simple", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    func test_polygonswapfade() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("polygon-swap-fade", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    func test_polygonswappop() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("polygon-swap-pop", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    func test_radiofolder() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("radio-folder", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    func test_radiohidechildren() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("radio-hide-children", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    func test_timeinherits() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("time-inherits", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    func test_timespanoverlay() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("time-span-overlay", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    func test_timestamppoint() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("time-stamp-point", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    func test_usacasf() {
        // refer code.google.com kml-samples project
        let kmlXmlUrl = bundle.URLForResource("usa-ca-sf", withExtension: "kml")
        let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
        let kml = kmlParser.parse()
        XCTAssertNotNil(kml)
        XCTAssert(0 == kmlParser.unSupported.count, "対象外がある" + kmlParser.unSupported.description)
    }
    func testCoodinates() {
        let parent:LinearRing = LinearRing(attributes: [:])
        let target:Coordinates = Coordinates()
        let contentsCase3Point:String = "-122.0856545755255,37.42243077405461,0"
        target.makeRelation(contentsCase3Point, parent: parent)
        XCTAssertEqual(target.value[0].longitude, "-122.0856545755255")
        XCTAssertEqual(target.value[0].latitude, "37.42243077405461")
        XCTAssertEqual(target.value[0].altitude, "0")
        
        let contentsCase3Points:String = " -122.0848938459612,37.42257124044786,17\n"
            + "        -122.0849580979198,37.42211922626856,17\n"
            + "        -122.0847469573047,37.42207183952619,17\n"
            + "        -122.0845725380962,37.42209006729676,17\n"
            + "        -122.0845954886723,37.42215932700895,17\n"
            + "        -122.0838521118269,37.42227278564371,17\n"
            + "        -122.083792243335,37.42203539112084,17\n"
            + "        -122.0835076656616,37.42209006957106,17\n"
            + "        -122.0834709464152,37.42200987395161,17\n"
            + "        -122.0831221085748,37.4221046494946,17\n"
            + "        -122.0829247374572,37.42226503990386,17\n"
            + "        -122.0829339169385,37.42231242843094,17\n"
            + "        -122.0833837359737,37.42225046087618,17\n"
            + "        -122.0833607854248,37.42234159228745,17\n"
            + "        -122.0834204551642,37.42237075460644,17\n"
            + "        -122.083659133885,37.42251292011001,17\n"
            + "        -122.0839758438952,37.42265873093781,17\n"
            + "        -122.0842374743331,37.42265143972521,17\n"
            + "        -122.0845036949503,37.4226514386435,17\n"
            + "        -122.0848020460801,37.42261133916315,17\n"
            + "        -122.0847882750515,37.42256395055121,17\n"
            + "        -122.0848938459612,37.42257124044786,17 "
        target.makeRelation(contentsCase3Points, parent: parent)
        XCTAssertEqual(target.value[0].longitude, "-122.0848938459612")
        XCTAssertEqual(target.value[0].latitude, "37.42257124044786")
        XCTAssertEqual(target.value[0].altitude, "17")
        // last value
        XCTAssertEqual(target.value.last!.longitude, "-122.0848938459612")
        XCTAssertEqual(target.value.last!.latitude, "37.42257124044786")
        XCTAssertEqual(target.value.last!.altitude, "17")
        
        let contentsCase2Points:String
        = "        138.64,-34.93 138.64,-34.94 138.63,-34.94 138.62,-34.94\n"
        + "        138.62,-34.95 138.62,-34.96 138.63,-34.96 138.62,-34.96\n"
        + "        138.61,-34.97 138.60,-34.97 138.59,-34.97 138.58,-34.97\n"
        + "        138.57,-34.97 138.57,-34.96 138.57,-34.95 138.57,-34.95\n"
        + "        138.57,-34.94 138.57,-34.93 138.57,-34.92 138.57,-34.92\n"
        + "        138.57,-34.91 138.56,-34.91 138.56,-34.90 138.57,-34.90\n"
        + "        138.57,-34.90 138.57,-34.89 138.57,-34.89 138.57,-34.89\n"
        + "        138.56,-34.88 138.56,-34.88 138.56,-34.88 138.56,-34.88\n"
        + "        138.57,-34.88 138.58,-34.87 138.58,-34.87 138.58,-34.86\n"
        + "        138.58,-34.85 138.58,-34.85 138.60,-34.85 138.61,-34.85\n"
        + "        138.63,-34.85 138.63,-34.85 138.64,-34.86 138.64,-34.87\n"
        + "        138.64,-34.87 138.63,-34.87 138.63,-34.88 138.62,-34.88\n"
        + "        138.62,-34.88 138.62,-34.89 138.62,-34.89 138.62,-34.89\n"
        + "        138.63,-34.89 138.63,-34.90 138.64,-34.90 138.64,-34.90\n"
        + "        138.64,-34.91 138.64,-34.91 138.64,-34.92 138.64,-34.92\n"
        + "        138.64,-34.93 138.64,-34.93"
        target.makeRelation(contentsCase2Points, parent: parent)
        XCTAssertEqual(target.value[0].longitude, "138.64")
        XCTAssertEqual(target.value[0].latitude, "-34.93")
        XCTAssertEqual(target.value[0].altitude, "")
        // last value
        XCTAssertEqual(target.value.last!.longitude, "138.64")
        XCTAssertEqual(target.value.last!.latitude, "-34.93")
        XCTAssertEqual(target.value.last!.altitude, "")
        
        
        let contentsCase2Point:String = "-122.0856545755255,37.42243077405461"
        target.makeRelation(contentsCase2Point, parent: parent)
        XCTAssertEqual(target.value[0].longitude, "-122.0856545755255")
        XCTAssertEqual(target.value[0].latitude, "37.42243077405461")
        XCTAssertEqual(target.value[0].altitude, "")
        
    }
    
    func testWhen() {
        let parent = TimeStamp(attributes: [:])
        let targetWhen:When = When()
        let contentsWhen = "2007-01-14T21:05:02Z"
        targetWhen.makeRelation(contentsWhen, parent: parent)
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        dateformatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateformatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        XCTAssertEqual(contentsWhen, dateformatter.stringFromDate(targetWhen.value))
        
    }
    func testBeginEnd(){
        let parent = TimeSpan(attributes: [:])
        let targetBegin:Begin = Begin()
        let contentsBegin = "2004-03"
        targetBegin.makeRelation(contentsBegin, parent: parent)
        
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyy'-'MM'"
        dateformatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateformatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        XCTAssertEqual(contentsBegin, dateformatter.stringFromDate(targetBegin.value))
        
        let targetEnd:End = End()
        let contentsEnd = "2004-04"
        targetEnd.makeRelation(contentsEnd, parent: parent)
        XCTAssertEqual(contentsEnd, dateformatter.stringFromDate(targetEnd.value))
    }
    
    func testPerformance_KML_Sample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
            let kmlXmlUrl = self.bundle.URLForResource("KML_Sample", withExtension: "kml")
            let kmlParser = SPXMLParser(Url: kmlXmlUrl!, root:Kml.self)
            let kml = kmlParser.parse()
            XCTAssertNotNil(kml)
        }
    }
    
}
