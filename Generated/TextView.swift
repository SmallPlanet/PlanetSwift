//
// Autogenerated by gaxb at 02:53:18 PM on 01/28/15
//

import UIKit

public class TextView: TextViewBase {

	lazy public var textView = UITextView()
    lazy public var textViewToolbar : UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
	lazy private var textViewDelegate = TextViewDelegateHelper()
    
	override open var view: UIView {
		get {
            if textView.delegate == nil {
                textView.delegate = textViewDelegate
            }
            return textView
		}
		set {
			if let newValue = newValue as? UITextView {
				textView = newValue
			}
		}
	}
	
	open override func gaxbPrepare() {
		super.gaxbPrepare()
		
		textViewDelegate.delegate = self
		
		if let text = text {
			textView.text = text
		}
		if let fontName = fontName {
            #if os(iOS)
                textView.font = UIFont(name: fontName, size: UIFont.systemFontSize)
            #else
                textView.font = UIFont(name: fontName, size: 18)
            #endif
		}
        if let fontSize = fontSize, textView.font != nil {
            textView.font = textView.font!.withSize(CGFloat(fontSize))
        }
		if let textColor = textColor {
			textView.textColor = textColor
		}
		if let textAlignment = textAlignment {
			textView.textAlignment = NSTextAlignment.fromPlanetUITextAlignment(textAlignment)
		}
		if let selectable = selectable {
			textView.isSelectable = selectable
		}
        #if os(iOS)
            if let editable = editable {
                textView.isEditable = editable
            }
        #endif
        if let tintColor = tintColor {
            textView.tintColor = tintColor
        }
        
        // Attach toolbar if either the left button text or
        // right button text is provided.
        
        if leftButtonText != nil || rightButtonText != nil {
            attachToolBar()
        }
        
        // set the keyboard type and force the keyboard.
        
        if let keyboardType = keyboardType {
            updateKeyboardType(keyboardType)
        }
        
        if forceKeyboard ?? false {
            textView.becomeFirstResponder()
        }
	}
    
	func textViewDidChange(_ textView: UITextView) {
        
        if let showMaxCount = showMaxCount, let maxCount = maxCount, showMaxCount {
            let updatedCount = Int(maxCount) - textView.text.count
            self.updateLeftButtonText(String(updatedCount))
        }
        
		if let onChange = onChange {
			doNotification(onChange)
		}
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		if let onEndEditing = onEndEditing {
			doNotification(onEndEditing)
		}
	}
    
    func textViewShouldChangeText(_ text: String) -> Bool {
        
        // Logic here to compute if there's a max count and if the text has exceeded it,
        // do not allow any more editing.
        
        if hasReachedMaxCount() {
            if text.count > Int(maxCount!)-1 {
                return false
            }
        }
        
        return true
    }
	
    func doNotification(_ note: String, _ userInfo: [String:String]? = nil) {
		let (scopeObject, name) = self.parseNotification(note)
		if let name = name {
            NotificationCenter.`default`.post(name: Foundation.Notification.Name(rawValue: name), object: scopeObject, userInfo: userInfo)
        }
	}
        
    public func updateText(_ newText: String?) {
        text = newText
        gaxbPrepare()
    }
    
    // Tool Bar Related (Left/Right Button Related)
    
    func attachToolBar() {
        
        var barButtonItems = [UIBarButtonItem]()
        
        textViewToolbar.barStyle = .default
        textViewToolbar.barTintColor = UIColor.white
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        if let leftButtonText = leftButtonText {
            let leftBarButton = generateLeftBarButton(leftButtonText)
            
            // Logic to control the enabled/disabled state depending on whether we are showing a counter
            // or a proper button.
            
            if showMaxCount ?? false {
                leftBarButton.isEnabled = false
                leftBarButton.title = String(Int(maxCount!))
            }
            
            barButtonItems.append(leftBarButton)
            barButtonItems.append(flexSpace)
        }
        
        if let rightButtonText = rightButtonText {
            let rightBarButton = generateRightBarButton(rightButtonText)
            barButtonItems.append(rightBarButton)
        }
        
        textViewToolbar.items = barButtonItems
        textViewToolbar.sizeToFit()
        
        textView.inputAccessoryView = textViewToolbar
    }
    
    func generateLeftBarButton(_ title: String) -> UIBarButtonItem {
        
        var leftBarButton : UIBarButtonItem
        
        // The left hand keyboard button, if configured to be a counter, will
        // not be an active button rather just a label. this will then be set up
        // as a "regular system" button that is not enabled.
        
        if let showMaxCount = showMaxCount {
            if showMaxCount {
                let leftBarButton = UIBarButtonItem()
                leftBarButton.target = self
                leftBarButton.action = #selector(leftButtonAction)
                leftBarButton.title = title
                return leftBarButton
            }
        }
        
        // If left hand button is not a counter (showMaxCount = false) then check if a color has been configured, if so,
        // generate the custom button and return it, if not, then create a system button and return it.
        
        if let leftBarButtonColor = leftButtonColor {
            
            // A left bar button color has been specified, if we are running iOS 11 or above, create the button from the custom view
            // if iOS 9 or above, then create the button from custom view, but set the frame explicitly.
            
            if let innerButton = createInnerButton(buttonColor: leftBarButtonColor, title: title, isLeft: true) {
                leftBarButton = UIBarButtonItem.init(customView: innerButton)
                return leftBarButton
            }
        }
        
        leftBarButton = UIBarButtonItem()
        leftBarButton.title = title
        leftBarButton.target = self
        leftBarButton.action = #selector(rightButtonAction)
        
        return leftBarButton
    }
    
    
    func generateRightBarButton(_ title: String) -> UIBarButtonItem {
        var rightBarButton : UIBarButtonItem
        
        if let rightBarButtonColor = rightButtonColor {
            
            // A right bar button color has been specified, if we are running iOS 11 or above, create the button from the custom view
            // if iOS 9 or above, then create the button from custom view, but set the frame explicitly.
            
            if let innerButton = createInnerButton(buttonColor: rightBarButtonColor, title: title, isLeft: false) {
                rightBarButton = UIBarButtonItem.init(customView: innerButton)
                return rightBarButton
            }
        }
        
        rightBarButton = UIBarButtonItem()
        rightBarButton.title = title
        rightBarButton.target = self
        rightBarButton.action = #selector(rightButtonAction)
        
        return rightBarButton
    }
    
    func createInnerButton(buttonColor: UIColor,  title: String, isLeft: Bool) -> UIButton? {
        
        if #available(iOS 11, *) {
            
            let innerButton = UIButton(type: .custom)
            innerButton.setTitle(title, for: .normal)
            innerButton.setTitleColor(buttonColor , for: .normal)
            
            // Determine 30% opacity and use as the highlighted (depressed) color
            // of the button.
            var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0
            if buttonColor.getRed(&r, green: &g, blue: &b, alpha: &a) {
                let highlightedColor = UIColor(red: r, green: g, blue: b, alpha: a * 0.30)
                innerButton.setTitleColor(highlightedColor, for: .highlighted)
            }
            innerButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
            
            if isLeft {
                innerButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
            } else {
                innerButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
            }
            
            return innerButton
            
        } else if #available(iOS 9, *) {
            
            let innerButton = UIButton(type: .custom)
            innerButton.frame = CGRect(x: 0, y:0, width: 165 , height: 36)
            innerButton.setTitle(title, for: .normal)
            innerButton.setTitleColor(buttonColor , for: .normal)
            
            // Determine 30% opacity and use as the highlighted (depressed) color
            // of the button.
            var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0
            if buttonColor.getRed(&r, green: &g, blue: &b, alpha: &a) {
                let highlightedColor = UIColor(red: r, green: g, blue: b, alpha: a * 0.30)
                innerButton.setTitleColor(highlightedColor, for: .highlighted)
            }
            
            innerButton.titleLabel?.font = title.count > 13 ? UIFont(name: "AvenirNext-DemiBold", size: 16) :  UIFont(name: "AvenirNext-DemiBold", size: 17)
            
            if isLeft {
                innerButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
                innerButton.contentHorizontalAlignment = .left
            } else {
                innerButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
                innerButton.contentHorizontalAlignment = .right
            }
            
            // set constraints manually. for iOS 10 support
            innerButton.widthAnchor.constraint(equalToConstant: innerButton.frame.size.width).isActive = true
            innerButton.heightAnchor.constraint(equalToConstant: innerButton.frame.size.height).isActive = true
            
            return innerButton
        }
        
        // We're running iOS 8 or below, should never happen, but just for safety.
        
        return nil
    }
    
    
    
// Toolbar Action Methods
    
    @objc func leftButtonAction() {
        if onLeftButton != nil {
            let userInfo : [String:String] = ["value":leftButtonText!]
            doNotification(onLeftButton!,userInfo)
        }
    }
    
    @objc func rightButtonAction() {
        if onRightButton != nil {
            let userInfo : [String:String]? = shouldAttachTextToNotification() ? ["value":textView.text] : nil
            doNotification(onRightButton!,userInfo)
        }
    }
    
// Helper Methods
    
// checks if text value should be included in notification., only check if max count has been met if the max count is required
// to attach, if the max count is NOT required, then just ensure the text has at least one character.
    
    func shouldAttachTextToNotification() -> Bool {
        
        if let requireMaxCount = requireMaxCount {
            if requireMaxCount && hasReachedMaxCount() {
                return true
            }
            
            if !requireMaxCount && textView.text.count > 0 {
                return true
            }
        }
    
        return false
    }
    
    
// will check if there is a max count specified (that's non trivial) and if the current text
// has reached the max.
    
    func hasReachedMaxCount() -> Bool {
        
        if let maxCount = maxCount, maxCount > 0 {
            if textView.text.count == Int(maxCount) {
                return true
            }
        }
        
        return false
    }
    
// Update keyboard Type
    
    public func updateKeyboardType(_ newKeyboardType: String?) {
        if let newKeyboardType = newKeyboardType {
            
            switch(newKeyboardType) {
            case "default":
                textView.keyboardType = .default
            case "asciiCapable":
                textView.keyboardType = .asciiCapable
            case "numbersAndPunctuation":
                textView.keyboardType = .numbersAndPunctuation
            case "URL":
                textView.keyboardType = .URL
            case "numberPad":
                textView.keyboardType = .numberPad
            case "phonePad":
                textView.keyboardType = .phonePad
            case "namePhonePad":
                textView.keyboardType = .namePhonePad
            case "emailAddress":
                textView.keyboardType = .emailAddress
            case "decimalPad":
                textView.keyboardType = .decimalPad
            case "twitter":
                textView.keyboardType = .twitter
            case "webSearch":
                textView.keyboardType = .webSearch
            case "asciiCapableNumberPad":
                if #available(iOS 10.0, *) {
                    textView.keyboardType = .asciiCapableNumberPad
                } else {
                    // Fallback on default
                    textView.keyboardType = .default
                }
            default:
                textView.keyboardType = .default
            }
            
        }
    }

    
// Toolbar Update Methods
    
    public func updateMaxCount(_ newMaxCount: Double?) {
        maxCount = newMaxCount
    }
    
    public func updateShowMaxCount(_ newShowMaxCount: Bool?) {
        showMaxCount = newShowMaxCount
        
        if showMaxCount! {
            self.updateLeftButtonText(String(Int(maxCount!)))
        }
    }
    
    public func updateRequireMaxCount(_ newRequireMaxCount: Bool?) {
        requireMaxCount = newRequireMaxCount
    }
    
    public func updateLeftButtonText(_ newText: String?) {
    
        if let barButtonItems = textViewToolbar.items, let newText = newText {
            
            leftButtonText = newText
            
            var updatedBarButtonItems : [UIBarButtonItem] = []
            // let leftBarButton: UIBarButtonItem = UIBarButtonItem(title: newText, style: .done, target: self, action:#selector(leftButtonAction))
            
            var leftBarButton : UIBarButtonItem? = UIBarButtonItem()
            if let leftButtonText = leftButtonText {
                leftBarButton = generateLeftBarButton(leftButtonText)
            
                if showMaxCount ?? false {
                    leftBarButton?.isEnabled = false
                } else {
                    leftBarButton?.isEnabled = true
                }
            }
            
            updatedBarButtonItems.append(leftBarButton!)
            updatedBarButtonItems.append(barButtonItems[1])
            updatedBarButtonItems.append(barButtonItems[2])
            
            textViewToolbar.items = nil;
            textViewToolbar.items = updatedBarButtonItems
            textViewToolbar.sizeToFit()
            
            // gaxbPrepare()
        }
    }
    
    public func updateRightButtonText(_ newText: String?) {
        
        if let barButtonItems = textViewToolbar.items, let newText = newText {
            
            var updatedBarButtonItems : [UIBarButtonItem] = []
            updatedBarButtonItems.append(barButtonItems[0])
            updatedBarButtonItems.append(barButtonItems[1])
            
            // clear current toolbar.
            textViewToolbar.items = nil;
            
            // build the updated right hand button.
            rightButtonText = newText
            
            //let rightBarButton: UIBarButtonItem = UIBarButtonItem(title: newText, style: .done, target: self, action:#selector(rightButtonAction))
            var rightBarButton: UIBarButtonItem = UIBarButtonItem()
            
            if let rightButtonText = rightButtonText {
                rightBarButton = generateRightBarButton(rightButtonText)
            }

            updatedBarButtonItems.append(rightBarButton)
            
            textViewToolbar.items = updatedBarButtonItems
            textViewToolbar.sizeToFit()
            
            // gaxbPrepare()
        }
    }
    
}



private class TextViewDelegateHelper : NSObject, UITextViewDelegate {
	
	weak var delegate:TextView?
	
    @objc func textViewDidChange(_ textView: UITextView) {
		
		if delegate != nil {
			delegate?.textViewDidChange(textView)
		}
	}
	
	@objc func textViewDidEndEditing(_ textView: UITextView) {
		
		if delegate != nil {
			delegate?.textViewDidChange(textView)
		}
	}
    
    @objc func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if delegate != nil {
            
            if let delegate = delegate  {
                if text.count > 0 {
                    return delegate.textViewShouldChangeText(textView.text)
                } else {
                    return true
                }
            } else {
                return true
            }
        }
        return true
        
    }

}
