//
// Autogenerated by gaxb at 02:35:55 PM on 12/17/14
//

import UIKit

// to find and dump localizable strings in a project, set _findLoclaizable to true
// and after using the app for a suitable period of time, run Label.printLocalizable()
// to get a dump of content ready for pasting into a .strings file
private let _findLocalizable = false
private var _localizable = Set<String>()

public class Label: LabelBase {
    
    lazy public var label = UILabel()
    override public var view: UIView {
        get {
            return label
        }
        set {
            if newValue is UILabel {
                label = newValue as! UILabel
            }
        }
    }
	
    public override func gaxbPrepare() {
        super.gaxbPrepare()
        var _paragraphStyle: NSMutableParagraphStyle?
        var paragraphStyle: NSMutableParagraphStyle {
            if _paragraphStyle == nil {
                _paragraphStyle = NSMutableParagraphStyle()
            }
            return _paragraphStyle!
        }
		
		if lineSpacing != nil {
			paragraphStyle.lineSpacing = CGFloat(lineSpacing!)
		}
        if textColor != nil {
            label.textColor = textColor
        }
        if adjustsFontSizeToFitWidth != nil {
            label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth!
        }
        label.minimumScaleFactor = CGFloat(minimumScaleFactor)
        if numberOfLines != nil {
            label.numberOfLines = numberOfLines!
        }
        if fontName != nil {
            label.font = UIFont(name: fontName!, size: UIFont.systemFontSize())
        }
        if fontSize != nil {
            label.font = label.font.fontWithSize(CGFloat(fontSize!))
        }
		
		//attributes that are sensitive to the existence (or non-existence) of _paragraphStyle
		if textAlignment != nil {
			if _paragraphStyle != nil {
				paragraphStyle.alignment = NSTextAlignment.fromPlanetUITextAlignment(textAlignment!)
			}
			label.textAlignment = NSTextAlignment.fromPlanetUITextAlignment(textAlignment!)
		}
		if lineBreakMode != nil {
			if _paragraphStyle != nil {
				paragraphStyle.lineBreakMode = NSLineBreakMode.fromPlanetUILineBreakMode(lineBreakMode!)
			}
			label.lineBreakMode = NSLineBreakMode.fromPlanetUILineBreakMode(lineBreakMode!)
		}
        
        let localizedText = text.map{NSLocalizedString($0, comment: "")} ?? ""
        
        checkUnlocalized(text, localized: localizedText)
        
        if _paragraphStyle != nil {
            let attributedString = NSMutableAttributedString(string: localizedText)
            let attributes = [NSParagraphStyleAttributeName : paragraphStyle]
            attributedString.setAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
            label.attributedText = attributedString
        } else {
            label.text = localizedText
        }
    }
    
    public func updateText(newText: String?) {
        text = newText
        gaxbPrepare()
    }
    
    func checkUnlocalized(text: String?, localized: String) {
        guard let text = text where text.characters.count > 0 && _findLocalizable else { return }
        let output = "\"\(text)\" = \"\(localized)\";"
        _localizable.insert(output)
    }
    
    public class func printLocalizable() {
        guard _findLocalizable else { return }
        print("//--------- localizable strings start --------")
        print("\n".join(Array(_localizable)))
        print("//---------- localizable strings end ---------")
    }
}
