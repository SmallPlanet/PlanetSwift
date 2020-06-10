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

class PlanetSwiftViewTests: XCTestCase {
    let testXMLString = """
<View xmlns='http://schema.smallplanet.com/PlanetSwift' frame='100.0,66.5,200.0,190.0' backgroundColor='#FF8040F8' contentCompressionResistancePriority='1,2' contentHuggingPriority='3,4' clipsToBounds='true' id='something'>
    <View frame='120.0,100.0,30.0,30.0' color='#C8EA00FF' alpha='0.9' clipsToBounds='false'/>
    <View frame='-50.0,10.0,80.0,80.0' color='#2266FF88' hidden='false' clipsToBounds='false' tag='3'/>
</View>
"""
    var element: GaxbElement?
    var subview0: View?
    var subview1: View?
    
    override func setUp() {
        super.setUp()
        element = PlanetUI.readFromString(testXMLString)
        if let view = element as? View {
            subview0 = view.anys[0] as? View
            subview1 = view.anys[1] as? View
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testView() {
        XCTAssert(element is View, "element is not a View")
    }
    
    func testUIView() {
        if let view = element as? View {
            XCTAssert(view.view.isKind(of: UIView.self), "element.view is not a UIView")
            XCTAssert(subview0!.view.isKind(of: UIView.self), "element subview0 is not a UIView")
            XCTAssert(subview1!.view.isKind(of: UIView.self), "element subview0 is not a UIView")
        }
    }

    func testSubviews() {
        if let view = element as? View {
            XCTAssertEqual(view.anys.count, 2, "Subviews count should be 2")
        }
    }
    
    func testViewFrame() {
        if let view = element as? View {
            XCTAssertEqual(view.view.frame.origin.x, CGFloat(100.0), "view frame origin x should be 100.0")
            XCTAssertEqual(view.view.frame.origin.y, CGFloat(66.5), "view frame origin y should be 66.5")
            XCTAssertEqual(view.view.frame.size.width, CGFloat(200.0), "view frame width should be 200.0")
            XCTAssertEqual(view.view.frame.size.height, CGFloat(190.0), "view frame height should be 190.0")
        }
    }
    
    func testViewColor() {
        if let view = element as? View {
            XCTAssertNotNil(view.backgroundColor, "view.backgroundColor is nil")
            if let color = view.backgroundColor {
                let (r,g,b,a) = color.getRGBA()
                XCTAssertEqual(r, CGFloat(1.0), "Color's red is incorrect")
                XCTAssertEqual(g, CGFloat(0x80/255.0), "Color's green is incorrect")
                XCTAssertEqual(b, CGFloat(0x40/255.0), "Color's blue is incorrect")
                XCTAssertEqual(a, CGFloat(0xF8/255.0), "Color's alpha is incorrect")
            }
        }
    }
    
    func testViewAlpha() {
        if let view = element as? View {
            XCTAssert(view.alpha == nil, "elements alpha should be nil")
            // when set with color and not with setAlpha, UIView's alpha = 1.0
            XCTAssertEqual(view.view.alpha, CGFloat(1.0), "UIView alpha is incorrect")
            
            XCTAssertEqual(subview0!.alpha!, 0.9, "subview0 alpha is incorrect")
            
            let x = subview0!.view.alpha
            let y = CGFloat(0.9)
            XCTAssertTrue(fabs(x-y) < CGFloat(FLT_EPSILON) * fabs(x+y), "subview0 UIView alpha is incorrect")
        }
    }
    
    func testViewClipsToBounds() {
        if let view = element as? View {
            XCTAssertTrue(view.clipsToBounds == true, "element clipsToBounds should be true")
            XCTAssertTrue(view.view.clipsToBounds == true, "element.view clipsToBounds should be true")
        }
    }
    
    func testObjectId() {
        if let view = element as? View {
            XCTAssertEqual(view.id!, "something", "Object.id not correct")
        }
    }
	
	func testViewCompressionResistance() {
		if let view = element as? View {
			XCTAssertEqual(view.view.contentCompressionResistancePriority(for: .horizontal), UILayoutPriority(1.0), "element.view horizontal content compression resistance should be 1")
			XCTAssertEqual(view.view.contentCompressionResistancePriority(for: .vertical), UILayoutPriority(2.0), "element.view horizontal content compression resistance should be 2")
		}
	}
	
	func testViewContentHugging() {
		if let view = element as? View {
			XCTAssertEqual(view.view.contentHuggingPriority(for: .horizontal), UILayoutPriority(3.0), "element.view horizontal content hugging should be 3")
			XCTAssertEqual(view.view.contentHuggingPriority(for: .vertical), UILayoutPriority(4.0), "element.view horizontal content hugging should be 4")
		}
	}
	
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
