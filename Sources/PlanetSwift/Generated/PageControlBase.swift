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

open class PageControlBase: View {

	open func customCopyTo(_ other: PageControl) {
        // can be overriden by subclasses to provide custom copying
    }

    open override func copy() -> GaxbElement {
        let copied = super.copy() as! PageControl
        copied.hidesForSinglePage = hidesForSinglePage
        copied.pageIndicatorTintColor = pageIndicatorTintColor
        copied.currentPageIndicatorTintColor = currentPageIndicatorTintColor

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
        if className == "PageControl" {
            return true
        }
        return super.isKindOfClass(className)
    }

	open var hidesForSinglePage: Bool?

    func hidesForSinglePageAsString() -> String {
        return hidesForSinglePage!.toGaxbString()
    }

    open func setHidesForSinglePage(_ value: String) {
        self.hidesForSinglePage = value == "true"
    }

	open var pageIndicatorTintColor: UIColor?

    func pageIndicatorTintColorAsString() -> String {
        return pageIndicatorTintColor!.toGaxbString()
    }

    open func setPageIndicatorTintColor(_ value: String) {
        pageIndicatorTintColor =  UIColor(gaxbString: value)
    }

	open var currentPageIndicatorTintColor: UIColor?

    func currentPageIndicatorTintColorAsString() -> String {
        return currentPageIndicatorTintColor!.toGaxbString()
    }

    open func setCurrentPageIndicatorTintColor(_ value: String) {
        currentPageIndicatorTintColor =  UIColor(gaxbString: value)
    }

    override open func setAttribute(_ value: String, key: String) {
        super.setAttribute(value, key: key)
        switch key {
        case "hidesForSinglePage":
            setHidesForSinglePage(value)
        case "pageIndicatorTintColor":
            setPageIndicatorTintColor(value)
        case "currentPageIndicatorTintColor":
            setCurrentPageIndicatorTintColor(value)
        default:
            break
        }
    }

    override open func imprintAttributes(_ receiver: GaxbElement?) -> GaxbElement? {

	if let obj = receiver as? ObjectBase {
            if originalValues["hidesForSinglePage"] != nil && obj.originalValues["hidesForSinglePage"] == nil {
				obj.setAttribute(originalValues["hidesForSinglePage"]!, key: "hidesForSinglePage")
            }
            if originalValues["pageIndicatorTintColor"] != nil && obj.originalValues["pageIndicatorTintColor"] == nil {
				obj.setAttribute(originalValues["pageIndicatorTintColor"]!, key: "pageIndicatorTintColor")
            }
            if originalValues["currentPageIndicatorTintColor"] != nil && obj.originalValues["currentPageIndicatorTintColor"] == nil {
				obj.setAttribute(originalValues["currentPageIndicatorTintColor"]!, key: "currentPageIndicatorTintColor")
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
            if hidesForSinglePage != nil {
                xml += " hidesForSinglePage='\(hidesForSinglePageAsString())'"
            }
                if pageIndicatorTintColor != nil {
                xml += " pageIndicatorTintColor='\(pageIndicatorTintColorAsString())'"
            }
                if currentPageIndicatorTintColor != nil {
                xml += " currentPageIndicatorTintColor='\(currentPageIndicatorTintColorAsString())'"
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
        var xml = "<PageControl"
        if parent == nil || parent?.xmlns != xmlns {
            xml += " xmlns='\(xmlns)'"
        }

        xml += attributesXML(useOriginalValues)

        let sXML = sequencesXML(useOriginalValues)
        xml += sXML == "" ? "/>": ">\(sXML)</PageControl>"
        return xml
    }

    override open func toXML() -> String {
        return toXML(false)
    }

    override open func description() -> String {
        return toXML()
    }

}
