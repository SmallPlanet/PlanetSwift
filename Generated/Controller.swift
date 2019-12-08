//
// Autogenerated by gaxb at 01:09:14 PM on 01/21/15
//

import UIKit

public class Controller: ControllerBase {

	public weak var controllerObject: UIViewController? {
		didSet {
			if let oldValue = oldValue {
				for notification in self.notifications {
                    let (_, name) = self.parseNotification(notification.scopedName)
					if let _ = name {
						NotificationCenter.`default`.removeObserver(oldValue, name: notification.name.map { NSNotification.Name(rawValue: $0) }, object: notification.scopeObject)
					}
				}
			}
			
			for notification in notifications {
				if let selector = notification.selector, let controllerObject = controllerObject {
					NotificationCenter.`default`.addObserver(controllerObject, selector: selector, name: notification.name.map { NSNotification.Name(rawValue: $0) }, object: notification.scopeObject)
				}
			}
		}
	}
}
