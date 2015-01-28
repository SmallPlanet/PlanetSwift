//
// Autogenerated by gaxb at 02:35:55 PM on 12/17/14
//

import UIKit

public class Label: LabelBase {
    
    lazy public var label = UILabel()
    override public var view: UIView {
        get {
            return label
        }
        set {
            if newValue is UILabel {
                label = newValue as UILabel
            }
        }
    }
    
    public override func gaxbPrepare() {
        super.gaxbPrepare()
        
        if text != nil {
            label.text = text!
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
        if textAlignment != nil {
            switch textAlignment! {
            case PlanetUI.TextAlignment.center:
                label.textAlignment = .Center
            case PlanetUI.TextAlignment.right:
                label.textAlignment = .Right
            case PlanetUI.TextAlignment.left:
                label.textAlignment = .Left
            case PlanetUI.TextAlignment.justified:
                label.textAlignment = .Justified
            case PlanetUI.TextAlignment.natural:
                label.textAlignment = .Natural
            }
        }
        if fontName != nil && fontSize != nil {
            label.font = UIFont(name: fontName!, size: CGFloat(fontSize!))
        }
    }
    
}
