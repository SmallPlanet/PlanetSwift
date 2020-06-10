//
//  PlanetSwiftTests.swift
//  PlanetSwiftTests
//
//  Created by Quinn McHenry on 12/11/14.
//  Copyright (c) 2014 Small Planet. All rights reserved.
//

import UIKit
import XCTest
import PlanetSwift

class PlanetSwiftTests: XCTestCase {
    let testXMLString = "<View xmlns='http://schema.smallplanet.com/PlanetSwift' frame='100.0,66.5,200.0,190.0' color='#FF8040F8' clipsToBounds='true' title='something'><View frame='120.0,100.0,30.0,30.0' color='#C8EA00FF' alpha='0.9' clipsToBounds='false'/><View frame='-50.0,10.0,80.0,80.0' color='#2266FF88' hidden='false' clipsToBounds='false' tag='3'/></View>"
    var element: GaxbElement?
    
    override func setUp() {
        super.setUp()
        element = PlanetUI.readFromString(testXMLString)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParse() {
        XCTAssert(element != nil, "Parsed element is nil")
    }

    func testImprintAttributes() {
        if let stamp = GaxbFactory.element("PlanetUI.View") as? View {
            stamp.id="coolview"
            stamp.hidden=true
            stamp.backgroundColor = UIColor.red
            if let receiver = GaxbFactory.element("PlanetUI.Label") as? Label {
                _ = stamp.imprintAttributes(receiver)
                XCTAssertNotNil(receiver.backgroundColor, "receiver.color is nil")
                if let color = receiver.backgroundColor {
                    let (r,_,_,_) = color.getRGBA()
                    XCTAssertEqual(r, CGFloat(1.0), "Color is incorrect")
                }
                XCTAssertEqual(receiver.id!, "coolview", "id does not match")
                XCTAssertEqual(receiver.hidden!, true, "hidden is not true")
            } else {
                XCTAssert(false, "Label should not be nil")
            }
        }
    }
    
}
