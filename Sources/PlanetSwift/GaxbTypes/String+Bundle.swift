//
//  String+Bundle.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/13/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import Foundation

extension String {

	public init(bundlePath: String) {
		self.init()
        let pathComponents = bundlePath.components(separatedBy: ":/")
        switch pathComponents[0] {
        case "bundle":
            if let resourcePath = Bundle.main.resourcePath {
                self = NSString(string: resourcePath).appendingPathComponent(pathComponents[1])
            }
        case "documents":
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            self = NSString(string: documentsPath).appendingPathComponent(pathComponents[1])
        case "cache":
            let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
            self = NSString(string: cachePath).appendingPathComponent(pathComponents[1])
        default:
            self = bundlePath
        }
	}

}
