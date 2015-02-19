//
// Autogenerated by gaxb at 05:04:35 PM on 02/19/15
//

import UIKit

public class GestureRecognizer: GestureRecognizerBase {
	
	public var recognizer:UIGestureRecognizer?
	private lazy var helper = GestureRecognizerHelper()
	
	public override func gaxbPrepare() {
		super.gaxbPrepare()
		
		if let recognizer = recognizer {
			
			if cancelsTouchesInView != nil {
				recognizer.cancelsTouchesInView = cancelsTouchesInView!
			}
			if delaysTouchesBegan != nil {
				recognizer.delaysTouchesBegan = delaysTouchesBegan!
			}
			if delaysTouchesEnded != nil {
				recognizer.delaysTouchesEnded = delaysTouchesEnded!
			}
			
			if onStateChange != nil {
				helper.delegate = self;
				recognizer.addTarget(helper, action: Selector("recognizerStateDidChange:"))
			}
		}
	}
	
	public override func gaxbDidPrepare() {
		super.gaxbDidPrepare()
		
		//TODO: clean up this pyramid once swift 1.2 is out
		if let recognizer = recognizer {
			if let view = view {
				
				let viewObj:AnyObject? = (scope() as? Object)?.objectForId(view)
				if let referencedView = viewObj as? View {
					referencedView.view.addGestureRecognizer(recognizer)
				}
			}
		}
	}
	
	func recognizerStateDidChange(recognizer:UIGestureRecognizer) {
		if onStateChange != nil {
			let (scopeObject: AnyObject?, name) = self.parseNotification(onStateChange)
			if name != nil {
				NSNotificationCenter.defaultCenter().postNotificationName(name!, object: scopeObject)
			}
		}
	}
}

class GestureRecognizerHelper: NSObject {
	weak var delegate: GestureRecognizer?
	
	func recognizerStateDidChange(recognizer:UIGestureRecognizer) {
		delegate?.recognizerStateDidChange(recognizer)
	}
}