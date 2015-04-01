//
// Autogenerated by gaxb at 06:41:41 PM on 12/27/14
//

import UIKit

private var config:NSDictionary?
private var attemptedConfigLoad = false

extension PlanetUI {
	
	//MARK: - config
	
    public class func configForKey(key: String) -> AnyObject? {
        checkLoadConfig()
        return config?.valueForKeyPath(key)
    }
    
    public class func configStringForKey(key: String) -> String? {
        return PlanetUI.configForKey(key) as? String
    }
    
    public class func configIntForKey(key: String) -> Int? {
        return PlanetUI.configStringForKey(key)?.toInt()
    }
    
    public class func configFloatForKey(key: String) -> Float? {
        return (PlanetUI.configForKey(key) as? NSString)?.floatValue
    }
    
    public class func configCGFloatForKey(key: String) -> CGFloat? {
        if let value = PlanetUI.configFloatForKey(key) {
            return CGFloat(value)
        }
        return nil
    }
    
    public class func configColorForKey(key: String) -> UIColor? {
        if let colorString = PlanetUI.configStringForKey(key) {
            return UIColor(gaxbString: colorString)
        }
        return nil
    }
	
	public class func configImageForKey(key: String) -> UIImage? {
		if let bundlePath = PlanetUI.configStringForKey(key) {
			if let image = UIImage(contentsOfFile: String(bundlePath: bundlePath)) {
				return image
			}
		}
		return nil
	}
	
	public class func configRemoteImageForKey(key: String, completion: ImageCache_CompletionBlock) {
		if let urlString = PlanetUI.configStringForKey(key) {
			if let url = NSURL(string: urlString) {
				ImageCache.sharedInstance.get(url, completion: completion)
			}
		}
	}
	
    private class func checkLoadConfig() {
        
        #if RELEASE
        println("")
        #endif

        if config == nil && !attemptedConfigLoad {
            attemptedConfigLoad = true
            if let path = PlanetSwiftConfiguration.valueForKey(PlanetSwiftConfiguration_configPathKey) as? String {
                config = NSDictionary(contentsOfFile: String(bundlePath: path))
            }
        }
    }
	
	//MARK: - processing expressions
	
    public class func processExpressions(string: String) -> String {
		var processedString = NSMutableString(string: string)
		if config != nil {
			findAndReplaceExpressions(processedString, expressionName:"config", configForKey)
		}
        return processedString
    }
	
	public class func findAndReplaceExpressions(stringToSearch:NSMutableString, expressionName:NSString, expressionEvaluatorBlock:(String->AnyObject?)) {
		
		var expressionSearchString = "@\(expressionName)("
		var searchRange = NSMakeRange(0, stringToSearch.length)
		while true {
			
			let startRange = stringToSearch.rangeOfString(expressionSearchString, options: NSStringCompareOptions.allZeros, range: searchRange)
			if startRange.location != NSNotFound {
				
				searchRange.location = startRange.location+startRange.length
				searchRange.length = stringToSearch.length-searchRange.location
				
				let endRange = stringToSearch.rangeOfString(")", options: NSStringCompareOptions.allZeros, range: searchRange)
				if endRange.location != NSNotFound {
					
					searchRange.location = endRange.location+endRange.length
					searchRange.length = stringToSearch.length-searchRange.location
					
					let expressionValue = stringToSearch.substringWithRange(NSMakeRange(startRange.location+startRange.length, endRange.location-(startRange.location+startRange.length)))
					if let replaceValue:AnyObject = expressionEvaluatorBlock(expressionValue) {
						
						let replaceString = "\(replaceValue)" as NSString
						let replaceLength = (endRange.location+endRange.length)-startRange.location
						stringToSearch.replaceCharactersInRange(NSMakeRange(startRange.location, replaceLength), withString: replaceString)
						
						//adjust the search range because we just changed the length / posision of the search range by replacing stuff
						let adjustNum = replaceString.length - replaceLength
						searchRange.location += adjustNum
						searchRange.length = stringToSearch.length-searchRange.location
					}
				}
				else {
					return
				}
			}
			else {
				return
			}
		}
	}
    
    // MARK: - helper methods
    
    // returns an array of all available fonts
    public class func fontNames() -> [String] {
        var names = [String]()
        for family in UIFont.familyNames() as [String] {
            for name in UIFont.fontNamesForFamilyName(family) {
                names.append(name as String)
            }
        }
        return names
    }
	
	public class func GCDDelay(delayAmount:Float, block:(Void->Void)) {
		dispatch_after(dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(delayAmount * Float(NSEC_PER_SEC))), dispatch_get_main_queue(), block)
	}
}
