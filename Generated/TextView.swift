//
// Autogenerated by gaxb at 02:53:18 PM on 01/28/15
//

import UIKit

public class TextView: TextViewBase {

	lazy public var textView = UITextView()
	lazy private var textViewDelegate = TextViewDelegateHelper()
	
	override public var view: UIView {
		get {
            if textView.delegate == nil {
                textView.delegate = textViewDelegate
            }
            return textView
		}
		set {
			if newValue is UITextView {
				textView = newValue as! UITextView
			}
		}
	}
	
	public override func gaxbPrepare() {
		super.gaxbPrepare()
		
		textViewDelegate.delegate = self
		
		if let text = text {
			textView.text = text
		}
		if let fontName = fontName {
			textView.font = UIFont(name: fontName, size: UIFont.systemFontSize())
		}
        if let fontSize = fontSize where textView.font != nil {
            textView.font = textView.font!.fontWithSize(CGFloat(fontSize))
        }
		if let textColor = textColor {
			textView.textColor = textColor
		}
		if let textAlignment = textAlignment {
			textView.textAlignment = NSTextAlignment.fromPlanetUITextAlignment(textAlignment)
		}
		if let selectable = selectable {
			textView.selectable = selectable
		}
		if let editable = editable {
			textView.editable = editable
		}
        if let tintColor = tintColor {
            textView.tintColor = tintColor
        }
	}
	
	func textViewDidChange(textView: UITextView) {
		if onChange != nil {
			doNotification(onChange!)
		}
	}
	
	func textViewDidEndEditing(textView: UITextView) {
		if onEndEditing != nil {
			doNotification(onEndEditing!)
		}
	}
	
	func doNotification(note: String) {
		let (scopeObject, name) = self.parseNotification(note)
		if name != nil {
			NSNotificationCenter.defaultCenter().postNotificationName(name!, object: scopeObject)
		}
	}
}

private class TextViewDelegateHelper : NSObject, UITextViewDelegate {
	
	weak var delegate:TextView?
	
	@objc func textViewDidChange(textView: UITextView) {
		
		if delegate != nil {
			delegate?.textViewDidChange(textView)
		}
	}
	
	@objc func textViewDidEndEditing(textView: UITextView) {
		
		if delegate != nil {
			delegate?.textViewDidChange(textView)
		}
	}
}