//
//  PlanetLabel.swift
//  PlanetSwift
//
//  Created by Christopher Schepman on 11/21/16.
//  Copyright © 2016 Small Planet. All rights reserved.
//

import UIKit

public class PlanetLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    public var textInsets = UIEdgeInsets.zero

    override public func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: textInsets)
        super.drawText(in: insetRect)
    }
}
