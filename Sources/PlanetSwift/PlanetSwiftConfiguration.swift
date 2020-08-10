//
//  PlanetSwiftConfiguration.swift
//  Terra
//
//  Created by Brad Bambara on 2/10/15.
//  Copyright (c) 2015 Terra Holdings. All rights reserved.
//

// swiftlint:disable identifier_name
// swiftlint:disable line_length

import Foundation

public let planetSwiftConfigurationAllParametersKey = "PlanetSwift"
public let planetSwiftConfigurationLightStylesheetPathKey = "styleSheetPath"
public let planetSwiftConfigurationDarkStylesheetPathKey = "darkStyleSheetPath"
public let planetSwiftConfigurationConfigPathKey = "configurationPath"

public class PlanetSwiftConfiguration {

	public class func valueForKey(_ key: String) -> AnyObject? {
        let dictionary = Bundle.main.object(forInfoDictionaryKey: planetSwiftConfigurationAllParametersKey) as? [String: AnyObject]
		return dictionary?[key]
	}
}
