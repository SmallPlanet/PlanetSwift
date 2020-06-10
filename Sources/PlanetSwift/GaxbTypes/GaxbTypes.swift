//
//  GaxbTypes.swift
//  Copyright (c) 2014 Small Planet. All rights reserved.
//

// swiftlint:disable large_tuple
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable line_length
// swiftlint:disable file_length

import UIKit

// MARK: - XSD datatypes

extension String: GaxbType {
    public init(gaxbString: String) {
        self.init()
        self.setWithGaxbString(gaxbString)
    }

    public mutating func setWithGaxbString(_ gaxbString: String) {
        self = gaxbString

        if gaxbString.starts(with: "@localization") {
            let key = extractParens(gaxbString)
            self = NSLocalizedString(key, comment: "")
        }

    }
    public func toGaxbString() -> String {
        return self
    }

    private func extractParens(_ gaxbString: String) -> String {
        if let start = gaxbString.firstIndex(of: "(") {
            if let end = gaxbString.lastIndex(of: ")") {
                return String(gaxbString[start...end].trimmingCharacters(in: CharacterSet(charactersIn: "()")))
            }
        }
        return gaxbString
    }

}

extension Bool: GaxbType {
    public init(gaxbString: String) {
        self.init()
        self.setWithGaxbString(gaxbString)
    }
    public mutating func setWithGaxbString(_ gaxbString: String) {
        switch gaxbString {
        case "true": self = true
        default: self = false
        }
    }
    public func toGaxbString() -> String {
        return self ? "true" : "false"
    }
}

extension Int: GaxbType {
    public init(gaxbString: String) {
        self.init()
        self.setWithGaxbString(gaxbString)
    }
    public mutating func setWithGaxbString(_ gaxbString: String) {
        if let tmp = Int(gaxbString) as Int? {
            self = tmp
        } else {
            self = 0
        }
    }
    public func toGaxbString() -> String {
        return String(self)
    }
}

extension Float: GaxbType {
    public init(gaxbString: String) {
        self.init()
        self.setWithGaxbString(gaxbString)
    }
    public mutating func setWithGaxbString(_ gaxbString: String) {
        self = (gaxbString as NSString).floatValue
    }
    public func toGaxbString() -> String {
        return String(format: "%.5f", self)
    }
}

extension Double: GaxbType {
    public init(gaxbString: String) {
        self.init()
        self.setWithGaxbString(gaxbString)
    }
    public mutating func setWithGaxbString(_ gaxbString: String) {
        self = (gaxbString as NSString).doubleValue
    }
    public func toGaxbString() -> String {
        return String(format: "%.5f", self)
    }
}

// MARK: - GAXB-defined types

extension CGRect: GaxbType {
    public init(gaxbString withGaxbString: String) {
        let (origin, size) = CGRect.componentsFromString(withGaxbString)
        self.init(origin: origin, size: size)
    }
    public mutating func setWithGaxbString(_ gaxbString: String) {
        let (newOrigin, newSize) = CGRect.componentsFromString(gaxbString)
        origin = newOrigin
        size = newSize
    }
    public static func componentsFromString(_ string: String) -> (CGPoint, CGSize) {
        var xxx: Float=0.0, yyy: Float=0.0, www: Float=0.0, hhh: Float=0.0
        let components = string.components(separatedBy: ",")
        if components.count == 4 {
            xxx = (components[0] as NSString).floatValue
            yyy = (components[1] as NSString).floatValue
            www = (components[2] as NSString).floatValue
            hhh = (components[3] as NSString).floatValue
        }
        let origin = CGPoint(x: CGFloat(xxx), y: CGFloat(yyy))
        let size = CGSize(width: CGFloat(www), height: CGFloat(hhh))
        return (origin, size)
    }
    public func toGaxbString() -> String {
        return "\(origin.x),\(origin.y),\(size.width),\(size.height)"
    }
}

extension UIEdgeInsets: GaxbType {
    public init(gaxbString withGaxbString: String) {
        let (top, left, bottom, right) = UIEdgeInsets.componentsFromString(withGaxbString)
        self = UIEdgeInsets.init(top: top, left: left, bottom: bottom, right: right)
    }
    public mutating func setWithGaxbString(_ gaxbString: String) {
        (top, left, bottom, right) = UIEdgeInsets.componentsFromString(gaxbString)
    }
    public static func componentsFromString(_ string: String) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        var ttt: Float=0.0, lll: Float=0.0, bbb: Float=0.0, rrr: Float=0.0
        let components = string.components(separatedBy: ",")
        if components.count == 4 {
            ttt = (components[0] as NSString).floatValue
            lll = (components[1] as NSString).floatValue
            bbb = (components[2] as NSString).floatValue
            rrr = (components[3] as NSString).floatValue
        }
        return (CGFloat(ttt), CGFloat(lll), CGFloat(bbb), CGFloat(rrr))
    }
    public func toGaxbString() -> String {
        return "\(top),\(left),\(bottom),\(right))"
    }
}

extension CGSize: GaxbType {
    public init(gaxbString: String) {
        let (width, height) = CGSize.componentsFromString(gaxbString)
        self.init(width: width, height: height)
    }
    mutating public func setWithGaxbString(_ gaxbString: String) {
        let (newWidth, newHeight) = CGPoint.componentsFromString(gaxbString)
        width = newWidth
        height = newHeight
    }
    public static func componentsFromString(_ string: String) -> (CGFloat, CGFloat) {
        var width: Float=0.0, height: Float=0.0
        let components = string.components(separatedBy: ",")
        if components.count == 2 {
            width = (components[0] as NSString).floatValue
            height = (components[1] as NSString).floatValue
        }
        return (CGFloat(width), CGFloat(height))
    }
    public func toGaxbString() -> String {
        return "\(width),\(height)"
    }
}

extension CGPoint: GaxbType {
    public init(gaxbString: String) {
        let (xxx, yyy) = CGPoint.componentsFromString(gaxbString)
        self.init(x: xxx, y: yyy)
    }
    mutating public func setWithGaxbString(_ gaxbString: String) {
        let (newX, newY) = CGPoint.componentsFromString(gaxbString)
        x = newX
        y = newY
    }
    public static func componentsFromString(_ string: String) -> (CGFloat, CGFloat) {
        var xxx: Float=0.0, yyy: Float=0.0
        let components = string.components(separatedBy: ",")
        if components.count == 2 {
            xxx = (components[0] as NSString).floatValue
            yyy = (components[1] as NSString).floatValue
        }
        return (CGFloat(xxx), CGFloat(yyy))
    }
    public func toGaxbString() -> String {
        return "\(x),\(y)"
    }
}

// MARK: - UIKit data types

extension UIImage {

    public convenience init?(gaxbString: String?) {
        guard let gaxbString = gaxbString else { return nil }
        if gaxbString.range(of: ":/") != nil {
            self.init(contentsOfFile: (String(bundlePath: gaxbString)))
        } else {
            self.init(named: gaxbString)
        }
    }

    public convenience init?(validateAndLoad name: String!) {
        self.init(named: name)

        // need to assert here if self.init fails
    }
}

extension UIColor {
    public convenience init(red: Int, green: Int, blue: Int) {
        let newRed   = CGFloat(Double(red) / 255.0)
        let newGreen = CGFloat(Double(green) / 255.0)
        let newBlue  = CGFloat(Double(blue) / 255.0)

        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: CGFloat(1.0))
    }
    public convenience init(gaxbString: String) {
        var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 1.0)
        if gaxbString.hasPrefix("#") {
            let substring = String(gaxbString[gaxbString.index(gaxbString.startIndex, offsetBy: 1)...])
            var hexNumber: UInt32 = 0
            _ = Scanner(string: substring).scanHexInt32(&hexNumber)
            switch substring.count {
            case 8:
                red = CGFloat((hexNumber & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255.0
                blue = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255.0
                alpha = CGFloat(hexNumber & 0x000000FF) / 255.0
            case 6:
                red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
                green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(hexNumber & 0x0000FF) / 255.0
            default: break
            }
        } else {
            switch gaxbString.lowercased() {
            case "red": red = 1.0
            case "green": green = 1.0
            case "blue": blue = 1.0
            case "white": red = 1.0; green = 1.0; blue = 1.0
            case "lightgray", "lightgrey": red = 0.827; green = red; blue = red
            case "gray", "grey": red = 0.5; green = red; blue = red
            case "darkgray", "darkgrey": red = 0.333; green = red; blue = red
            case "purple": red = 0.5; blue = 0.5
            case "clear": alpha = 0
            default: break
            }
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    public func setWithGaxbString(_ gaxbString: String) {
        // immutable
    }
    public func toGaxbString() -> String {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let hexNumber = Int(red*255) << 24 + Int(green*255) << 16 + Int(blue*255) << 8 + Int(alpha*255)
            return NSString(format: "#%08X", hexNumber) as String
        }
        return ""
    }
    public func getRGBA() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (-1.0, -1.0, -1.0, -1.0)
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}

// MARK: - enum conversion

extension UIButton.ButtonType {
    public static func fromPlanetUIButtonType(_ type: PlanetUI.ButtonType) -> UIButton.ButtonType {
        return self.init(withPlanetButtonType: type)
    }
    public init(withPlanetButtonType type: PlanetUI.ButtonType) {
        switch type {
        case .custom:
            self = .custom
        case .system:
            self = .system
        case .detailDisclosure:
            self = .detailDisclosure
        case .infoLight:
            self = .infoLight
        case .infoDark:
            self = .infoDark
        case .contactAdd:
            self = .contactAdd
        }
    }
}

extension NSTextAlignment {
    public static func fromPlanetUITextAlignment(_ alignment: PlanetUI.TextAlignment) -> NSTextAlignment {
        return self.init(withPlanetTextAlignment: alignment)
    }
    public init(withPlanetTextAlignment alignment: PlanetUI.TextAlignment) {
        switch alignment {
        case .center:
            self = NSTextAlignment.center
        case .right:
            self = NSTextAlignment.right
        case .left:
            self = NSTextAlignment.left
        case .justified:
            self = NSTextAlignment.justified
        case .natural:
            self = NSTextAlignment.natural
        }
    }
}

extension NSLineBreakMode {
    public static func fromPlanetUILineBreakMode(_ mode: PlanetUI.LineBreakMode) -> NSLineBreakMode {
        return self.init(withPlanetLineBreakMode: mode)
    }
    public init(withPlanetLineBreakMode mode: PlanetUI.LineBreakMode) {
        switch mode {
        case .truncatingTail:
            self = .byTruncatingTail
        case .wordWrapping:
            self = .byWordWrapping
        case .charWrapping:
            self = .byCharWrapping
        case .truncatingHead:
            self = .byTruncatingHead
        case .clipping:
            self = .byClipping
        case .truncatingMiddle:
            self = .byTruncatingMiddle
        }
    }
}

#if os(iOS)
extension UIDatePicker.Mode {
    public static func fromPlanetUIDatePickerMode(_ mode: PlanetUI.DatePickerMode) -> UIDatePicker.Mode {
        return self.init(withPlanetDatePickerMode: mode)
    }
    public init(withPlanetDatePickerMode mode: PlanetUI.DatePickerMode) {
        switch mode {
        case .time:
            self = UIDatePicker.Mode.time
        case .date:
            self = UIDatePicker.Mode.date
        case .dateAndTime:
            self = UIDatePicker.Mode.dateAndTime
        case .countDownTimer:
            self = UIDatePicker.Mode.countDownTimer
        }
    }
}
#endif

extension UITextField.BorderStyle {
    public static func fromPlanetUITextFieldBorderStyle(_ style: PlanetUI.TextBorderStyle) -> UITextField.BorderStyle {
        return self.init(withPlanetTextBorderStyle: style)
    }
    public init(withPlanetTextBorderStyle style: PlanetUI.TextBorderStyle) {
        switch style {
        case .line:
            self = .line
        case .bezel:
            self = .bezel
        case .roundedRect:
            self = .roundedRect
        default:
            self = .none
        }
    }
}

extension UITextField.ViewMode {
    public static func fromPlanetUITextFieldViewMode(_ mode: PlanetUI.TextFieldViewMode) -> UITextField.ViewMode {
        return self.init(withPlanetTextFieldViewMode: mode)
    }
    public init(withPlanetTextFieldViewMode mode: PlanetUI.TextFieldViewMode) {
        switch mode {
        case .always:
            self = .always
        case .never:
            self = .never
        case .unlessEditing:
            self = .unlessEditing
        case .whileEditing:
            self = .whileEditing
        }
    }
}

extension UIView.ContentMode {
    public static func fromPlanetUIContentMode(_ mode: PlanetUI.ContentMode) -> UIView.ContentMode {
        return self.init(withPlanetContentMode: mode)
    }
    public init(withPlanetContentMode mode: PlanetUI.ContentMode) {
        switch mode {
        case .scaleToFill:
            self = .scaleToFill
        case .scaleAspectFit:
            self = .scaleAspectFit
        case .scaleAspectFill:
            self = .scaleAspectFill
        case .redraw:
            self = .redraw
        case .center:
            self = .center
        case .top:
            self = .top
        case .bottom:
            self = .bottom
        case .left:
            self = .left
        case .right:
            self = .right
        case .topLeft:
            self = .topLeft
        case .topRight:
            self = .topRight
        case .bottomLeft:
            self = .bottomLeft
        case .bottomRight:
            self = .bottomRight
        }
    }
}

extension UIAccessibilityTraits {
    public static func fromPlanetUIAccessibilityTraits(trait: PlanetUI.AccessibilityTraits) -> UIAccessibilityTraits {
        return self.init(withPlanetAccessibilityTraits: trait)
    }
    public init(withPlanetAccessibilityTraits trait: PlanetUI.AccessibilityTraits) {
        switch trait {
        case .none:
            self = UIAccessibilityTraits.none
        case .button:
            self = UIAccessibilityTraits.button
        case .link:
            self = UIAccessibilityTraits.link
        case .searchField:
            self = UIAccessibilityTraits.searchField
        case .image:
            self = UIAccessibilityTraits.image
        case .selected:
            self = UIAccessibilityTraits.selected
        case .playsSound:
            self = UIAccessibilityTraits.playsSound
        case .keyboardKey:
            self = UIAccessibilityTraits.keyboardKey
        case .staticText:
            self = UIAccessibilityTraits.staticText
        case .summaryElement:
            self = UIAccessibilityTraits.summaryElement
        case .notEnabled:
            self = UIAccessibilityTraits.notEnabled
        case .updatesFrequently:
            self = UIAccessibilityTraits.updatesFrequently
        case .startsMediaSession:
            self = UIAccessibilityTraits.startsMediaSession
        case .adjustable:
            self = UIAccessibilityTraits.adjustable
        case .allowsDirectInteraction:
            self = UIAccessibilityTraits.allowsDirectInteraction
        case .causesPageTurn:
            self = UIAccessibilityTraits.causesPageTurn
        case .header:
            self = UIAccessibilityTraits.header
        }
    }
}

extension UIReturnKeyType {
    public static func fromPlanetUIReturnKeyType(_ type: PlanetUI.ReturnKeyType) -> UIReturnKeyType {
        return self.init(withPlanetReturnKeyType: type)
    }
    public init(withPlanetReturnKeyType type: PlanetUI.ReturnKeyType) {
        switch type {
        case .default:
            self = .default
        case .go:
            self = .go
        case .google:
            self = .google
        case .join:
            self = .join
        case .next:
            self = .next
        case .route:
            self = .route
        case .search:
            self = .search
        case .send:
            self = .send
        case .yahoo:
            self = .yahoo
        case .done:
            self = .done
        case .emergencyCall:
            self = .emergencyCall
        }
    }
}

extension UIKeyboardType {
    public static func fromPlanetUIKeyboardType(_ type: PlanetUI.KeyboardType) -> UIKeyboardType {
        return self.init(withPlanetKeyboardType: type)
    }
    public init(withPlanetKeyboardType type: PlanetUI.KeyboardType) {
        switch type {
        case .default:
            self = .default
        case .asciiCapable:
            self = .asciiCapable
        case .numbersAndPunctuation:
            self = .numbersAndPunctuation
        case .URL:
            self = .URL
        case .numberPad:
            self = .numberPad
        case .phonePad:
            self = .phonePad
        case .namePhonePad:
            self = .namePhonePad
        case .emailAddress:
            self = .emailAddress
        case .decimalPad:
            self = .decimalPad
        case .twitter:
            self = .twitter
        case .webSearch:
            self = .webSearch
        }
    }
}

#if os(iOS)
extension UIActivityIndicatorView.Style {
    public static func fromPlanetUIActivityIndicatorViewStyle(_ type: PlanetUI.ActivityIndicatorViewStyle) -> UIActivityIndicatorView.Style {
        return self.init(withPlanetActivityIndicatorViewStyle: type)
    }
    public init(withPlanetActivityIndicatorViewStyle style: PlanetUI.ActivityIndicatorViewStyle) {
        switch style {
        case .whiteLarge:
            self = .whiteLarge
        case .white:
            self = .white
        case .gray:
            self = .gray
        }
    }
}
#endif

extension UITextAutocapitalizationType {
    public static func fromPlanetUITextAutocapitalizationType(_ type: PlanetUI.TextAutocapitalizationType) -> UITextAutocapitalizationType {
        return self.init(withPlanetTextAutocapitalizationType: type)
    }
    public init(withPlanetTextAutocapitalizationType type: PlanetUI.TextAutocapitalizationType) {
        switch type {
        case .none:
            self = .none
        case .words:
            self = .words
        case .sentences:
            self = .sentences
        case .allCharacters:
            self = .allCharacters
        }
    }
}

extension UITextAutocorrectionType {
    public static func fromPlanetUITextAutocorrectionType(_ type: PlanetUI.TextAutocorrectionType) -> UITextAutocorrectionType {
        return self.init(withPlanetTextAutocorrectionType: type)
    }
    public init(withPlanetTextAutocorrectionType type: PlanetUI.TextAutocorrectionType) {
        switch type {
        case .default:
            self = .default
        case .no:
            self = .no
        case .yes:
            self = .yes
        }
    }
}

extension UITextSpellCheckingType {
    public static func fromPlanetUITextSpellCheckingType(_ type: PlanetUI.TextSpellCheckingType) -> UITextSpellCheckingType {
        return self.init(withPlanetTextSpellCheckingType: type)
    }
    public init(withPlanetTextSpellCheckingType type: PlanetUI.TextSpellCheckingType) {
        switch type {
        case .default:
            self = .default
        case .no:
            self = .no
        case .yes:
            self = .yes
        }
    }
}
