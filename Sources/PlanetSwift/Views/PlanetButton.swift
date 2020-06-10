//
//  PlanetButton.swift
//  PlanetSwift
//
//  Created by Nicholas Bowlin on 1/21/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

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
    var _backgroundColorHighlighted: UIColor? {
        return backgroundColorHighlighted != nil ? backgroundColorHighlighted : backgroundColorNormal
    }
    
    var backgroundColorSelected: UIColor?
    var _backgroundColorSelected: UIColor? {
        return backgroundColorSelected != nil ? backgroundColorSelected : _backgroundColorHighlighted
    }
    
    var backgroundColorSelectedHighlighted: UIColor?
    var _backgroundColorSelectedHighlighted: UIColor? {
        return backgroundColorSelectedHighlighted != nil ? backgroundColorSelectedHighlighted : _backgroundColorHighlighted
    }
    
    var backgroundColorDisabled: UIColor?
    var _backgroundColorDisabled: UIColor? {
        return backgroundColorDisabled != nil ? backgroundColorDisabled : backgroundColorNormal
    }
	
	private func updateBackgroundColor() {
		
		if isEnabled == false {
			backgroundColor = _backgroundColorDisabled
		}
		else {
			switch (isHighlighted, isSelected) {
			case (true, false):
				checkBackgroundColor(_backgroundColorHighlighted)
			case (true, true):
				checkBackgroundColor(_backgroundColorSelectedHighlighted)
			case (false, true):
				checkBackgroundColor(_backgroundColorSelected)
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
	
    func checkBackgroundColor(_ color: UIColor?)
    {
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
    
    convenience init(bgColor: UIColor, bgColorHighlighted: UIColor, bgColorSelected: UIColor, bgColorSelectedHighlighted: UIColor, bgColorDisabled: UIColor, toggle: Bool)
    {
        self.init();
        backgroundColorNormal = bgColor
        backgroundColorHighlighted = bgColorHighlighted
        backgroundColorSelected = bgColorSelected
        backgroundColorSelectedHighlighted = bgColorSelectedHighlighted
        isToggle = toggle
        addTarget(self, action: #selector(PlanetButton.touchUpInside(_:)), for: .touchUpInside)
    }
    
}
