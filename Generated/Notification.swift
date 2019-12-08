//
// Autogenerated by gaxb at 10:50:37 PM on 01/09/15
//

import UIKit

public class Notification: NotificationBase {
    public weak var scopeObject: AnyObject?
    public var name: String?
    
    open override func gaxbPrepare() {
        super.gaxbPrepare()
        if let scopedName = scopedName {
            (self.scopeObject, self.name) = self.parseNotification(scopedName)
        }
    }
    
    public var selector: Selector? {
        get {
            guard let name = name else { return nil }
            return Selector(name + ":")
        }
    }
        
}
