//
// Autogenerated by gaxb at 05:06:37 PM on 06/10/20
//

// swiftlint:disable superfluous_disable_command
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable identifier_name
// swiftlint:disable force_cast
// swiftlint:disable type_body_length
// swiftlint:disable function_body_length
// swiftlint:disable line_length
// swiftlint:disable file_length

import UIKit

open class ViewBase: Object {

	open func customCopyTo(_ other: View) {
        // can be overriden by subclasses to provide custom copying
    }

    open override func copy() -> GaxbElement {
        let copied = super.copy() as! View
        copied.externalClass = externalClass
        copied.frame = frame
        copied.backgroundColor = backgroundColor
        copied.alpha = alpha
        copied.hidden = hidden
        copied.clipsToBounds = clipsToBounds
        copied.userInteractionEnabled = userInteractionEnabled
        copied.tag = tag
        copied.contentMode = contentMode
        copied.contentHuggingPriority = contentHuggingPriority
        copied.contentCompressionResistancePriority = contentCompressionResistancePriority
        copied.accessibilityLabel = accessibilityLabel
        copied.accessibilityHint = accessibilityHint
        copied.accessibilityTraits = accessibilityTraits
        copied.borderColor = borderColor
        copied.borderWidth = borderWidth
        copied.cornerRadius = cornerRadius
        copied.shadowOffset = shadowOffset
        copied.shadowOpacity = shadowOpacity
        copied.shadowRadius = shadowRadius
        copied.shadowColor = shadowColor
        copied.masksToBounds = masksToBounds

		customCopyTo(copied)

        return copied
    }

	open override func visit(_ visitor: (GaxbElement) -> Void) {
        super.visit(visitor)

	}

    override open func setElement(_ element: GaxbElement, key: String) {
        super.setElement(element, key: key)
    }

    override  open func isKindOfClass(_ className: String) -> Bool {
        if className == "View" {
            return true
        }
        return super.isKindOfClass(className)
    }

	open var externalClass: String?

    func externalClassAsString() -> String {
        return externalClass ?? ""
    }

    open func setExternalClass(_ value: String) {
        self.externalClass = String(gaxbString: value)
    }

	open var frame: CGRect?

    func frameAsString() -> String {
        return frame!.toGaxbString()
    }

    open func setFrame(_ value: String) {
        frame =  CGRect(gaxbString: value)
    }

	open var backgroundColor: UIColor?

    func backgroundColorAsString() -> String {
        return backgroundColor!.toGaxbString()
    }

    open func setBackgroundColor(_ value: String) {
        backgroundColor =  UIColor(gaxbString: value)
    }

	open var alpha: Double?

    func alphaAsString() -> String {
        return alpha!.toGaxbString()
    }

    open func setAlpha(_ value: String) {
        self.alpha = (value as NSString).doubleValue
    }

	open var hidden: Bool?

    func hiddenAsString() -> String {
        return hidden!.toGaxbString()
    }

    open func setHidden(_ value: String) {
        self.hidden = value == "true"
    }

	open var clipsToBounds: Bool?

    func clipsToBoundsAsString() -> String {
        return clipsToBounds!.toGaxbString()
    }

    open func setClipsToBounds(_ value: String) {
        self.clipsToBounds = value == "true"
    }

	open var userInteractionEnabled: Bool?

    func userInteractionEnabledAsString() -> String {
        return userInteractionEnabled!.toGaxbString()
    }

    open func setUserInteractionEnabled(_ value: String) {
        self.userInteractionEnabled = value == "true"
    }

	open var tag: Int?

    func tagAsString() -> String {
        return tag!.toGaxbString()
    }

    open func setTag(_ value: String) {
        self.tag = Int(value)!
    }

	open var contentMode: PlanetUI.ContentMode?

    func contentModeAsString() -> String {
        return contentMode!.rawValue
    }

    open func setContentMode(_ value: String) {
        if let tmp = PlanetUI.ContentMode(rawValue: value) {
            contentMode = tmp
        }
    }

	open var contentHuggingPriority: CGPoint?

    func contentHuggingPriorityAsString() -> String {
        return contentHuggingPriority!.toGaxbString()
    }

    open func setContentHuggingPriority(_ value: String) {
        contentHuggingPriority =  CGPoint(gaxbString: value)
    }

	open var contentCompressionResistancePriority: CGPoint?

    func contentCompressionResistancePriorityAsString() -> String {
        return contentCompressionResistancePriority!.toGaxbString()
    }

    open func setContentCompressionResistancePriority(_ value: String) {
        contentCompressionResistancePriority =  CGPoint(gaxbString: value)
    }

	open var accessibilityLabel: String?

    func accessibilityLabelAsString() -> String {
        return accessibilityLabel ?? ""
    }

    open func setAccessibilityLabel(_ value: String) {
        self.accessibilityLabel = String(gaxbString: value)
    }

	open var accessibilityHint: String?

    func accessibilityHintAsString() -> String {
        return accessibilityHint ?? ""
    }

    open func setAccessibilityHint(_ value: String) {
        self.accessibilityHint = String(gaxbString: value)
    }

	open var accessibilityTraits: PlanetUI.AccessibilityTraits?

    func accessibilityTraitsAsString() -> String {
        return accessibilityTraits!.rawValue
    }

    open func setAccessibilityTraits(_ value: String) {
        if let tmp = PlanetUI.AccessibilityTraits(rawValue: value) {
            accessibilityTraits = tmp
        }
    }

	open var borderColor: UIColor?

    func borderColorAsString() -> String {
        return borderColor!.toGaxbString()
    }

    open func setBorderColor(_ value: String) {
        borderColor =  UIColor(gaxbString: value)
    }

	open var borderWidth: Double?

    func borderWidthAsString() -> String {
        return borderWidth!.toGaxbString()
    }

    open func setBorderWidth(_ value: String) {
        self.borderWidth = (value as NSString).doubleValue
    }

	open var cornerRadius: Double?

    func cornerRadiusAsString() -> String {
        return cornerRadius!.toGaxbString()
    }

    open func setCornerRadius(_ value: String) {
        self.cornerRadius = (value as NSString).doubleValue
    }

	open var shadowOffset: CGSize?

    func shadowOffsetAsString() -> String {
        return shadowOffset!.toGaxbString()
    }

    open func setShadowOffset(_ value: String) {
        shadowOffset =  CGSize(gaxbString: value)
    }

	open var shadowOpacity: Double?

    func shadowOpacityAsString() -> String {
        return shadowOpacity!.toGaxbString()
    }

    open func setShadowOpacity(_ value: String) {
        self.shadowOpacity = (value as NSString).doubleValue
    }

	open var shadowRadius: Double?

    func shadowRadiusAsString() -> String {
        return shadowRadius!.toGaxbString()
    }

    open func setShadowRadius(_ value: String) {
        self.shadowRadius = (value as NSString).doubleValue
    }

	open var shadowColor: UIColor?

    func shadowColorAsString() -> String {
        return shadowColor!.toGaxbString()
    }

    open func setShadowColor(_ value: String) {
        shadowColor =  UIColor(gaxbString: value)
    }

	open var masksToBounds: Bool?

    func masksToBoundsAsString() -> String {
        return masksToBounds!.toGaxbString()
    }

    open func setMasksToBounds(_ value: String) {
        self.masksToBounds = value == "true"
    }

    override open func setAttribute(_ value: String, key: String) {
        super.setAttribute(value, key: key)
        switch key {
        case "externalClass":
            setExternalClass(value)
        case "frame":
            setFrame(value)
        case "backgroundColor":
            setBackgroundColor(value)
        case "alpha":
            setAlpha(value)
        case "hidden":
            setHidden(value)
        case "clipsToBounds":
            setClipsToBounds(value)
        case "userInteractionEnabled":
            setUserInteractionEnabled(value)
        case "tag":
            setTag(value)
        case "contentMode":
            setContentMode(value)
        case "contentHuggingPriority":
            setContentHuggingPriority(value)
        case "contentCompressionResistancePriority":
            setContentCompressionResistancePriority(value)
        case "accessibilityLabel":
            setAccessibilityLabel(value)
        case "accessibilityHint":
            setAccessibilityHint(value)
        case "accessibilityTraits":
            setAccessibilityTraits(value)
        case "borderColor":
            setBorderColor(value)
        case "borderWidth":
            setBorderWidth(value)
        case "cornerRadius":
            setCornerRadius(value)
        case "shadowOffset":
            setShadowOffset(value)
        case "shadowOpacity":
            setShadowOpacity(value)
        case "shadowRadius":
            setShadowRadius(value)
        case "shadowColor":
            setShadowColor(value)
        case "masksToBounds":
            setMasksToBounds(value)
        default:
            break
        }
    }

    override open func imprintAttributes(_ receiver: GaxbElement?) -> GaxbElement? {

	if let obj = receiver as? ObjectBase {
            if originalValues["externalClass"] != nil && obj.originalValues["externalClass"] == nil {
				obj.setAttribute(originalValues["externalClass"]!, key: "externalClass")
            }
            if originalValues["frame"] != nil && obj.originalValues["frame"] == nil {
				obj.setAttribute(originalValues["frame"]!, key: "frame")
            }
            if originalValues["backgroundColor"] != nil && obj.originalValues["backgroundColor"] == nil {
				obj.setAttribute(originalValues["backgroundColor"]!, key: "backgroundColor")
            }
            if originalValues["alpha"] != nil && obj.originalValues["alpha"] == nil {
				obj.setAttribute(originalValues["alpha"]!, key: "alpha")
            }
            if originalValues["hidden"] != nil && obj.originalValues["hidden"] == nil {
				obj.setAttribute(originalValues["hidden"]!, key: "hidden")
            }
            if originalValues["clipsToBounds"] != nil && obj.originalValues["clipsToBounds"] == nil {
				obj.setAttribute(originalValues["clipsToBounds"]!, key: "clipsToBounds")
            }
            if originalValues["userInteractionEnabled"] != nil && obj.originalValues["userInteractionEnabled"] == nil {
				obj.setAttribute(originalValues["userInteractionEnabled"]!, key: "userInteractionEnabled")
            }
            if originalValues["tag"] != nil && obj.originalValues["tag"] == nil {
				obj.setAttribute(originalValues["tag"]!, key: "tag")
            }
            if originalValues["contentMode"] != nil && obj.originalValues["contentMode"] == nil {
				obj.setAttribute(originalValues["contentMode"]!, key: "contentMode")
            }
            if originalValues["contentHuggingPriority"] != nil && obj.originalValues["contentHuggingPriority"] == nil {
				obj.setAttribute(originalValues["contentHuggingPriority"]!, key: "contentHuggingPriority")
            }
            if originalValues["contentCompressionResistancePriority"] != nil && obj.originalValues["contentCompressionResistancePriority"] == nil {
				obj.setAttribute(originalValues["contentCompressionResistancePriority"]!, key: "contentCompressionResistancePriority")
            }
            if originalValues["accessibilityLabel"] != nil && obj.originalValues["accessibilityLabel"] == nil {
				obj.setAttribute(originalValues["accessibilityLabel"]!, key: "accessibilityLabel")
            }
            if originalValues["accessibilityHint"] != nil && obj.originalValues["accessibilityHint"] == nil {
				obj.setAttribute(originalValues["accessibilityHint"]!, key: "accessibilityHint")
            }
            if originalValues["accessibilityTraits"] != nil && obj.originalValues["accessibilityTraits"] == nil {
				obj.setAttribute(originalValues["accessibilityTraits"]!, key: "accessibilityTraits")
            }
            if originalValues["borderColor"] != nil && obj.originalValues["borderColor"] == nil {
				obj.setAttribute(originalValues["borderColor"]!, key: "borderColor")
            }
            if originalValues["borderWidth"] != nil && obj.originalValues["borderWidth"] == nil {
				obj.setAttribute(originalValues["borderWidth"]!, key: "borderWidth")
            }
            if originalValues["cornerRadius"] != nil && obj.originalValues["cornerRadius"] == nil {
				obj.setAttribute(originalValues["cornerRadius"]!, key: "cornerRadius")
            }
            if originalValues["shadowOffset"] != nil && obj.originalValues["shadowOffset"] == nil {
				obj.setAttribute(originalValues["shadowOffset"]!, key: "shadowOffset")
            }
            if originalValues["shadowOpacity"] != nil && obj.originalValues["shadowOpacity"] == nil {
				obj.setAttribute(originalValues["shadowOpacity"]!, key: "shadowOpacity")
            }
            if originalValues["shadowRadius"] != nil && obj.originalValues["shadowRadius"] == nil {
				obj.setAttribute(originalValues["shadowRadius"]!, key: "shadowRadius")
            }
            if originalValues["shadowColor"] != nil && obj.originalValues["shadowColor"] == nil {
				obj.setAttribute(originalValues["shadowColor"]!, key: "shadowColor")
            }
            if originalValues["masksToBounds"] != nil && obj.originalValues["masksToBounds"] == nil {
				obj.setAttribute(originalValues["masksToBounds"]!, key: "masksToBounds")
            }
       }
       return super.imprintAttributes(receiver)
    }

    override open func attributesXML(_ useOriginalValues: Bool) -> String {
        var xml = ""
        if useOriginalValues {
            for (key, value) in originalValues {
                xml += " \(key)='\(value)'"
            }
        } else {
            if externalClass != nil {
                xml += " externalClass='\(externalClassAsString())'"
            }
                if frame != nil {
                xml += " frame='\(frameAsString())'"
            }
                if backgroundColor != nil {
                xml += " backgroundColor='\(backgroundColorAsString())'"
            }
                if alpha != nil {
                xml += " alpha='\(alphaAsString())'"
            }
                if hidden != nil {
                xml += " hidden='\(hiddenAsString())'"
            }
                if clipsToBounds != nil {
                xml += " clipsToBounds='\(clipsToBoundsAsString())'"
            }
                if userInteractionEnabled != nil {
                xml += " userInteractionEnabled='\(userInteractionEnabledAsString())'"
            }
                if tag != nil {
                xml += " tag='\(tagAsString())'"
            }
                if contentMode != nil {
                xml += " contentMode='\(contentModeAsString())'"
            }
                if contentHuggingPriority != nil {
                xml += " contentHuggingPriority='\(contentHuggingPriorityAsString())'"
            }
                if contentCompressionResistancePriority != nil {
                xml += " contentCompressionResistancePriority='\(contentCompressionResistancePriorityAsString())'"
            }
                if accessibilityLabel != nil {
                xml += " accessibilityLabel='\(accessibilityLabelAsString())'"
            }
                if accessibilityHint != nil {
                xml += " accessibilityHint='\(accessibilityHintAsString())'"
            }
                if accessibilityTraits != nil {
                xml += " accessibilityTraits='\(accessibilityTraitsAsString())'"
            }
                if borderColor != nil {
                xml += " borderColor='\(borderColorAsString())'"
            }
                if borderWidth != nil {
                xml += " borderWidth='\(borderWidthAsString())'"
            }
                if cornerRadius != nil {
                xml += " cornerRadius='\(cornerRadiusAsString())'"
            }
                if shadowOffset != nil {
                xml += " shadowOffset='\(shadowOffsetAsString())'"
            }
                if shadowOpacity != nil {
                xml += " shadowOpacity='\(shadowOpacityAsString())'"
            }
                if shadowRadius != nil {
                xml += " shadowRadius='\(shadowRadiusAsString())'"
            }
                if shadowColor != nil {
                xml += " shadowColor='\(shadowColorAsString())'"
            }
                if masksToBounds != nil {
                xml += " masksToBounds='\(masksToBoundsAsString())'"
            }
            }
        xml += super.attributesXML(useOriginalValues)

        return xml
    }

    override open func sequencesXML(_ useOriginalValues: Bool) -> String {
        var xml = ""
        xml += super.sequencesXML(useOriginalValues)

        return xml
    }

    override open func toXML(_ useOriginalValues: Bool) -> String {
        var xml = "<View"
        if parent == nil || parent?.xmlns != xmlns {
            xml += " xmlns='\(xmlns)'"
        }

        xml += attributesXML(useOriginalValues)

        let sXML = sequencesXML(useOriginalValues)
        xml += sXML == "" ? "/>": ">\(sXML)</View>"
        return xml
    }

    override open func toXML() -> String {
        return toXML(false)
    }

    override open func description() -> String {
        return toXML()
    }

}