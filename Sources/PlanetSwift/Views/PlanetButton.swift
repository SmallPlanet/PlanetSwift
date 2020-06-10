//
//  PlanetButton.swift
//  PlanetSwift
//
//  Created by Nicholas Bowlin on 1/21/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

// swiftlint:disable line_length

import UIKit

public class PlanetButton: UIButton {

    public var touchUpInsideHandler: (() -> Void)?

	var isToggle = false

    var backgroundColorNormal: UIColor? {
        didSet {
            backgroundColor = backgroundColorNormal
        }
    }

    var backgroundColorHighlighted: UIColor?
    var localBackgroundColorHighlighted: UIColor? {
        return backgroundColorHighlighted != nil ? backgroundColorHighlighted : backgroundColorNormal
    }

    var backgroundColorSelected: UIColor?
    var localBackgroundColorSelected: UIColor? {
        return backgroundColorSelected != nil ? backgroundColorSelected : localBackgroundColorHighlighted
    }

    var backgroundColorSelectedHighlighted: UIColor?
    var localBackgroundColorSelectedHighlighted: UIColor? {
        return backgroundColorSelectedHighlighted != nil ? backgroundColorSelectedHighlighted : localBackgroundColorHighlighted
    }

    var backgroundColorDisabled: UIColor?
    var localBackgroundColorDisabled: UIColor? {
        return backgroundColorDisabled != nil ? backgroundColorDisabled : backgroundColorNormal
    }

	private func updateBackgroundColor() {

		if isEnabled == false {
			backgroundColor = localBackgroundColorDisabled
		} else {
			switch (isHighlighted, isSelected) {
			case (true, false):
				checkBackgroundColor(localBackgroundColorHighlighted)
			case (true, true):
				checkBackgroundColor(localBackgroundColorSelectedHighlighted)
			case (false, true):
				checkBackgroundColor(localBackgroundColorSelected)
			default:
				checkBackgroundColor(backgroundColorNormal)
			}
		}
	}

    public override var isEnabled: Bool {
        didSet {
			updateBackgroundColor()
        }
    }

    public override var isHighlighted: Bool {
        didSet {
            updateBackgroundColor()
        }
    }

	public override var isSelected: Bool {
		didSet {
			updateBackgroundColor()
		}
	}

    func checkBackgroundColor(_ color: UIColor?) {
        if color != nil {
            backgroundColor = color!
        }
    }

    @objc func touchUpInside(_ sender: UIButton!) {
        if isToggle {
            isSelected = !isSelected
        }
        touchUpInsideHandler?()
    }

    // MARK: - Initializers

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self, action: #selector(PlanetButton.touchUpInside(_:)), for: .touchUpInside)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(PlanetButton.touchUpInside(_:)), for: .touchUpInside)
    }

    convenience init(bgColor: UIColor,
                     bgColorHighlighted: UIColor,
                     bgColorSelected: UIColor,
                     bgColorSelectedHighlighted: UIColor,
                     bgColorDisabled: UIColor,
                     toggle: Bool) {
        self.init()
        backgroundColorNormal = bgColor
        backgroundColorHighlighted = bgColorHighlighted
        backgroundColorSelected = bgColorSelected
        backgroundColorSelectedHighlighted = bgColorSelectedHighlighted
        isToggle = toggle
        addTarget(self, action: #selector(PlanetButton.touchUpInside(_:)), for: .touchUpInside)
    }

}
