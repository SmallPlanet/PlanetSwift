//
// Autogenerated by gaxb at 02:34:28 PM on 02/20/15
//

// swiftlint:disable force_cast

import UIKit

public class CollectionView: CollectionViewBase {
    lazy public var collectionView = UICollectionView(frame: CGRect.zero,
                                                      collectionViewLayout: UICollectionViewFlowLayout())
    override public var view: UIView {
        get {
            return collectionView
        }
        set {
            if let newValue = newValue as? UICollectionView {
                collectionView = newValue
            }
        }
    }

    // MARK: - Layout

    func newLayout() -> UICollectionViewLayout? {
        let layoutClass = NSClassFromString(self.layoutClass) as! NSObject.Type
        if let layoutObject = layoutClass.init() as? UICollectionViewLayout {
            return layoutObject
        }
        return UICollectionViewFlowLayout()
    }
}