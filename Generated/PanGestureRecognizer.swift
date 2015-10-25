//
// Autogenerated by gaxb at 05:04:35 PM on 02/19/15
//

import UIKit

public class PanGestureRecognizer: PanGestureRecognizerBase {

	lazy public var panRecognizer = UIPanGestureRecognizer()
	override public var recognizer: UIGestureRecognizer? {
		get {
			return panRecognizer
		}
		set {
			if newValue is UIPanGestureRecognizer {
				panRecognizer = newValue as! UIPanGestureRecognizer
			}
		}
	}
	
	public override func gaxbPrepare() {
		super.gaxbPrepare()
		
        #if os(iOS)
            if maximumNumberOfTouches != nil {
                panRecognizer.maximumNumberOfTouches = maximumNumberOfTouches!
            }
            if minimumNumberOfTouches != nil {
                panRecognizer.minimumNumberOfTouches = minimumNumberOfTouches!
            }
        #endif
	}
}
