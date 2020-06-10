//
//  PlanetView.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/13/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

public class PlanetView: UIView {

	public var xmlView: View?
	@IBInspectable public var bundlePath: String? {
		didSet {
			loadXMLView()
		}
	}

	// MARK: - loading / unloading view

	func loadXMLView() {
        guard let bundlePath = bundlePath, xmlView == nil else { return }

        xmlView = PlanetUI.readFromFile(String(bundlePath: bundlePath)) as? View
        if let loadedView = xmlView?.view {
            addSubview(loadedView)
        }
        xmlView?.visit { element in
            element.gaxbDidPrepare()
        }
	}
}
