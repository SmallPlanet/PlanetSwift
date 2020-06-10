//
//  PlanetSwiftConstraintTests.swift
//  PlanetSwiftTests
//
//  Created by Quinn McHenry on 5/29/19.
//  Copyright © 2019 Small Planet. All rights reserved.
//

import UIKit
import XCTest
import PlanetSwift

class PlanetSwiftConstraintTests: XCTestCase {
    let testXMLString = """
<Scene id="root" frame="0,0,400,600" backgroundColor="blue"
    xmlns='http://schema.smallplanet.com/PlanetUI'>
    <Label id="label1"
        text="Top"
        fontName="AppleSDGothicNeo-UltraLight"
        textAlignment="center"
        fontSize="60"
        backgroundColor="#0eeeeeff" />
    <Constraint firstItem="label1" firstAttribute="centerX"
        secondItem="root" secondAttribute="centerX"/>
    <Constraint firstItem="label1" firstAttribute="top"
        secondItem="root" secondAttribute="top"/>
</Scene>
"""
    
    var element: GaxbElement?
    var scene: Scene?
    var label: View?
    
    override func setUp() {
        super.setUp()
        element = PlanetUI.readFromString(testXMLString)
        element?.visit() { element in
            element.gaxbDidPrepare()
        }
        scene = element as? Scene
        if let view = element as? View {
            label = view.anys[0] as? View
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    func testView() {
        XCTAssert(element is View, "element is not a View")
    }
    
    func testUIView() {
        if let view = element as? View {
            XCTAssert(view.view.isKind(of: UIView.self), "element.view is not a UIView")
            XCTAssert(label!.view.isKind(of: UILabel.self), "element subview0 is not a UIView")
        }
    }
    
    func testConstraintsExist() {
        let constraints = scene!.view.constraints
        XCTAssertEqual(constraints.count, 2)
    }

}
