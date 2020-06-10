//
//  PlanetSwiftConfiguration.swift
//  Terra
//
//  Created by Brad Bambara on 2/10/15.
//  Copyright (c) 2015 Terra Holdings. All rights reserved.
//

import Foundation

public let PlanetSwiftConfiguration_allParametersKey = "PlanetSwift"
public let PlanetSwiftConfiguration_stylesheetPathKey = "styleSheetPath"
public let PlanetSwiftConfiguration_configPathKey = "configurationPath"

public class PlanetSwiftConfiguration {
	
	public class func valueForKey(_ key:String) -> AnyObject? {
		let dictionary = Bundle.main.object(forInfoDictionaryKey: PlanetSwiftConfiguration_allParametersKey) as? Dictionary<String, AnyObject>
		return dictionary?[key]
	}
}
