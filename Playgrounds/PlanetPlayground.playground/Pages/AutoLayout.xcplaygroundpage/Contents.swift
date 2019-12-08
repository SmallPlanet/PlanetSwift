//: [Previous page](@previous) 
//#-hidden-code

import UIKit
import PlanetSwift
import PlaygroundSupport

let hostView = setupHostView()

//#-end-hidden-code
/*:
 # AutoLayout
 * No other layout option in iOS provides as much flexibility as AutoLayout.
 * It also provides a healthy learning curve.
 *
 * This playground demonstrates simple autolayout capabilities of PlanetSwift
 * and a means of quickly exploring autolayout in general.
 */


let xml = """
<Scene id="root" backgroundColor="#05C2FC"
    xmlns='http://schema.smallplanet.com/PlanetUI'>

    <Constraint firstItem="root" ruleSet="fillSuperview"/>

    <Label id="label1" text="Top" fontSize="60" fontName="AppleSDGothicNeo-UltraLight" textAlignment="center" backgroundColor="darkGray" textColor="white" />
    <Constraint firstItem="label1" firstAttribute="centerX" secondItem="root" secondAttribute="centerX" constant="-80"/>
    <Constraint firstItem="label1" firstAttribute="top" secondItem="root" secondAttribute="top" constant="40"/>

    <Label id="label2" text="Trailing" fontSize="60" fontName="AppleSDGothicNeo-UltraLight" textAlignment="center" backgroundColor="darkGrey" textColor="white"/>
    <Constraint firstItem="label2" firstAttribute="leading" secondItem="label1" secondAttribute="trailing"/>
    <Constraint firstItem="label2" firstAttribute="top" secondItem="label1" secondAttribute="baseline"/>

    <View id="box" backgroundColor="gray" borderColor="white" borderWidth="5" />
    <Constraint firstItem="box" firstAttribute="width" secondItem="root" secondAttribute="width" multiplier="0.5"/>
    <Constraint firstItem="box" firstAttribute="height" secondItem="circle" secondAttribute="width" multiplier="0.5"/>
    <Constraint firstItem="box" firstAttribute="centerX" secondItem="root" secondAttribute="centerX"/>
    <Constraint firstItem="box" firstAttribute="top" secondItem="label2" secondAttribute="bottom" constant="30"/>

    <ImageView id="logo" image='logo.png' contentMode='aspectFit'/>
    <Constraint firstItem="logo" secondItem="box" ruleSet="equalCenter"/>

    <View id="circle" backgroundColor="lightGrey" cornerRadius="100">
        <Label id="labelSP" text="SP" fontSize="120" textColor="#FC15BB" backgroundColor="clear" fontName="AvenirNext-Bold"/>
        <Constraint firstItem="labelSP" secondItem="parent" ruleSet="equalCenter"/>
    </View>
    <Constraint firstItem="circle" firstAttribute="width" constant="200"/>
    <Constraint firstItem="circle" firstAttribute="height" constant="200"/>
    <Constraint firstItem="root" firstAttribute="right" secondItem="circle" secondAttribute="right" constant="50"/>
    <Constraint firstItem="root" firstAttribute="bottom" secondItem="circle" secondAttribute="bottom" constant="50"/>

</Scene>
"""

//#-hidden-code

if let view = PlanetUI.readFromString(xml) as? View {
    hostView.addSubview(view.view)
    view.visit() { element in
        element.gaxbDidPrepare()
        print(element)
    }
}

PlaygroundPage.current.liveView = hostView

//#-end-hidden-code
