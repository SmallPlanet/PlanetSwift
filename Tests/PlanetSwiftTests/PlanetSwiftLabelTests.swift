//
//  PlanetSwiftLabelTests.swift
//  PlanetSwift
//
//  Created by Quinn McHenry on 12/17/14.
//  Copyright (c) 2014 Small Planet. All rights reserved.
//

import UIKit
import PlanetSwift
import XCTest

class PlanetSwiftLabelTests: XCTestCase {
    let testXMLString = """
<View xmlns='http://schema.smallplanet.com/PlanetUI'
    frame='0.0,0.0,768.0,1024.0'
    title='scene'>
    <Label text='Some text'
        fontName='Avenir-Light'
        fontSize='20.00000'
        textColor='#FF0000FF'
        textAlignment='center'
        minimumScaleFactor='0.5'
        numberOfLines='2'
        frame='0.0,300.0,320.0,100.0'
        color='#2266FF22'/>
    <Label text='A very very very very Merry Swiftmas!'
        fontName='Avenir-Light'
        fontSize='20.00000'
        textColor='#FF0000FF'
        textAlignment='right'
        adjustsFontSizeToFitWidth='true'
        minimumScaleFactor='0.00000'
        numberOfLines='1'
        frame='50.0,400.0,240.0,100.0'/>
</View>
"""
    var element: GaxbElement?
    var label0: Label?
    var label1: Label?
    
    override func setUp() {
        super.setUp()
        element = PlanetUI.readFromString(testXMLString)
        if let view = element as? View {
            if let label = view.anys[0] as? Label {
                label0 = label
            }
            if let label = view.anys[1] as? Label {
                label1 = label
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLabelsParse() {
        // This is an example of a functional test case.
        XCTAssertNotNil(label0, "Label #0 is nil")
        XCTAssertNotNil(label1, "Label #1 is nil")
    }
    
    func testLabelViews() {
        XCTAssert(label0!.label.isKind(of: UILabel.self), "label0 does not have a UILabel")
        XCTAssert(label1!.label.isKind(of: UILabel.self), "label1 does not have a UILabel")
    }
    
    func testLabelTextAlignmentEnum() {
        XCTAssertEqual(PlanetUI.TextAlignment.center.rawValue, "center", "TextAlignment enum Center invalid")
        XCTAssertEqual(PlanetUI.TextAlignment.left.rawValue, "left", "TextAlignment enum Left invalid")
        XCTAssertEqual(PlanetUI.TextAlignment.right.rawValue, "right", "TextAlignment enum Right invalid")
        XCTAssertEqual(PlanetUI.TextAlignment.justified.rawValue, "justified", "TextAlignment enum Justified invalid")
        XCTAssertEqual(PlanetUI.TextAlignment.natural.rawValue, "natural", "TextAlignment enum Natural invalid")
    }
    
    func testLabelTextAlignment() {
        XCTAssertEqual(label0!.textAlignment!, PlanetUI.TextAlignment.center, "Label element textAlignment not properly set");
        XCTAssert(label0!.label.textAlignment == .center, "Label UIKit textAlignment not properly set");
        XCTAssertEqual(label1!.textAlignment!, PlanetUI.TextAlignment.right, "Label element textAlignment not properly set");
        XCTAssert(label1!.label.textAlignment == .right, "Label UIKit textAlignment not properly set");
    }
    
    func testLabelAttributes() {
        // text
        XCTAssertEqual(label0!.text!, "Some text", "Label element text value incorrect")
        XCTAssertEqual(label0!.label.text!, "Some text", "Label UIKit text value incorrect")
        // minimumScaleFactor
        XCTAssertEqual(label0!.minimumScaleFactor, 0.5, "Label element minimumScaleFactor incorrect")
        XCTAssertEqual(label0!.label.minimumScaleFactor, CGFloat(0.5), "Label UIKit minimumScaleFactor incorrect")
        // numberOfLines
        XCTAssertEqual(label0!.numberOfLines!, 2, "Label elelment numberOfLines incorrect")
        XCTAssertEqual(label0!.label.numberOfLines, 2, "Label UIKit numberOfLines incorrect")
        // adjustsFontSizeToFitWidth
        XCTAssertNil(label0!.adjustsFontSizeToFitWidth, "Undefined Label element adjustsFontSizeToWidth should be nil")
        XCTAssertTrue(label1!.adjustsFontSizeToFitWidth!, "Label element adjustsFontSizeToFitWidth incorrect")
        XCTAssertTrue(label1!.label.adjustsFontSizeToFitWidth, "Label UIKit adustsFontSizeToFitWidth incorrect")
    }

    func testLabelFont() {
        XCTAssert(label0!.label.font != nil, "UIFont undefined for Label")
        XCTAssertEqual(label0!.fontName!, "Avenir-Light", "Label element fontName incorrect")
        XCTAssertEqual(label0!.label.font.fontName, "Avenir-Light", "Label.font UIKit fontName incorrect")
        XCTAssertEqual(label0!.fontSize!, 20.0, "Label element fontSize incorrect")
        XCTAssertEqual(label0!.label.font.pointSize, CGFloat(20.0), "Label.font UIKit fontSize incorrect")
    }
}
