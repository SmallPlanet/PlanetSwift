//
// Autogenerated by gaxb at 03:49:32 PM on 06/30/18
//

// swiftlint:disable force_cast

import Foundation

open class PlanetCode {

    var parentCode: Code?

    open func setAttribute(_ value: String, key: String) { }
    open func gaxbPrepare() { }
    open func gaxbDidPrepare() { }
    open func objectForId<T>(_ item: String) -> T? {
        return (parentCode!.scope() as? Object)?.objectForId(item) as? T
    }
    public required init() { }
}

open class Code: CodeBase {

    var codeObject: PlanetCode?

    open override func customCopyTo(_ other: Code) {
        if self.codeObject != nil {
            other.codeObject = self.codeObject
            other.codeObject?.parentCode = other
        }
    }

    private func swiftClassFromString(_ className: String) -> AnyClass! {
        if  let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String? {
            return NSClassFromString("\(appName).\(className)")
        }
        return nil
    }

    open override func setAttribute(_ value: String, key: String) {
        super.setAttribute(value, key: key)

        if key == "className" {
            let codeObjectClass = swiftClassFromString(className!) as! PlanetCode.Type
            codeObject = codeObjectClass.init()
            codeObject?.parentCode = self
        }

        if codeObject != nil {
            codeObject?.setAttribute(value, key: key)
        }
    }

    open override func gaxbPrepare() {
        super.gaxbPrepare()

        if codeObject != nil {
            codeObject?.gaxbPrepare()
        }
    }

    open override func gaxbDidPrepare() {
        super.gaxbDidPrepare()

        if codeObject != nil {
            codeObject?.gaxbDidPrepare()
        }
    }
}