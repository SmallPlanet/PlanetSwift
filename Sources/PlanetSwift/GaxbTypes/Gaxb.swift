//
//  Gaxb.swift
//  PlanetCore
//
//  Created by Quinn McHenry on 7/4/14.
//  Copyright (c) 2014 Small Planet Digital. All rights reserved.
//

import UIKit

public protocol GaxbElement: class {
    var xmlns: String { get }
	var parent: GaxbElement? { get set }
    func gaxbPrepare()
    func visit(_ visitor: (GaxbElement) -> ())
	func gaxbDidPrepare()
	func setElement(_ element: GaxbElement, key:String)
    func setParent(_: GaxbElement)
    func isKindOfClass(_ className: String) -> Bool
    func setAttribute(_ value: String, key:String)
    func imprintAttributes(_ receiver: GaxbElement?) -> GaxbElement?
    func attributesXML(_ useOriginalValues:Bool) -> String
    func sequencesXML(_ useOriginalValues:Bool) -> String
    func toXML(_ useOriginalValues:Bool) -> String
    func toXML() -> String
    func description() -> String
	func copy() -> GaxbElement
}

public protocol GaxbType {
    init(gaxbString: String)
    mutating func setWithGaxbString(_ GaxbString: String)
    func toGaxbString() -> String
}

public class GaxbFactory: NSObject {
    public func classWithName(_ name : String) -> GaxbElement? {
        return nil
    }
    
    public class func factory(_ namespace: String) -> AnyObject? {
        guard let factoryClass = NSClassFromString(namespace + "GaxbFactory") as? NSObject.Type else { return nil }
        return factoryClass.init()
    }
    
    public class func element(_ namespace: String, name: String) -> GaxbElement? {
        guard let factory = self.factory(namespace) as? GaxbFactory else { return nil }
        return factory.classWithName(name)
    }
    
    public class func element(_ fullname: String) -> GaxbElement? {
        let components = fullname.components(separatedBy: ".")
        return components.count == 2 ? self.element(components[0], name: components[1]) : nil
    }
}

