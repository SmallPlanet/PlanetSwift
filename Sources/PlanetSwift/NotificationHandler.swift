//
//  NotificationHandler.swift
//  PlanetSwift
//
//  Created by Quinn McHenry on 9/4/15.
//  Copyright © 2015 Small Planet. All rights reserved.
//

// Sample implementation:
//
//  enum Notification: String, NotificationHandler {
//      case SomethingImportant
//      case SystemTimeChanged
//    
//      var name: String {
//          switch self {
//          case .SystemTimeChanged: return NSSystemClockDidChangeNotification
//          default: return rawValue
//          }
//      }
//  }
//
// Sample usage:
//    Notification.SomethingImportant.observe(self, selector: Selector("importantHandler:"))
//    ...
//    Notification.SomethingImportant.post()

// swiftlint:disable line_length

import Foundation

public protocol NotificationHandler {
    var name: String { get }
    func post(_ object: AnyObject?, userInfo: [NSObject: AnyObject]?)
    func observe(_ observer: AnyObject, selector: Selector, object: AnyObject?)
    func remove(_ observer: AnyObject, object: AnyObject?)
    static func remove(_ observer: AnyObject)
}

public extension NotificationHandler {

    func post(_ object: AnyObject? = nil, userInfo: [NSObject: AnyObject]? = nil) {
        NotificationCenter.`default`.post(name: Foundation.Notification.Name(rawValue: name), object: object, userInfo: userInfo)
    }
    func observe(_ observer: AnyObject, selector: Selector, object: AnyObject? = nil) {
        NotificationCenter.`default`.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: object)
    }
    func remove(_ observer: AnyObject, object: AnyObject? = nil) {
        NotificationCenter.`default`.removeObserver(observer, name: NSNotification.Name(rawValue: name), object: object)
    }
    static func remove(_ observer: AnyObject) {
        NotificationCenter.`default`.removeObserver(observer)
    }
}
