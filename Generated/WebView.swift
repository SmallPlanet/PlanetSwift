//
// Autogenerated by gaxb at 05:45:15 PM on 01/21/15
//

import UIKit

public class WebView: WebViewBase {
    lazy public var webview = UIWebView()
    
    override open var view: UIView {
        get {
            return webview
        }
        set {
            if let newValue = newValue as? UIWebView {
                webview = newValue
            }
        }
    }
    
    open override func gaxbPrepare() {
        super.gaxbPrepare()
        
        if let url = url, let requestURL = URL(string: url) {
            let request = URLRequest(url: requestURL)
            webview.loadRequest(request)
        }
        if let scalesToFit = scalesToFit {
            webview.scalesPageToFit = scalesToFit
        }
        if let suppressesIncrementalRendering = suppressesIncrementalRendering {
            webview.suppressesIncrementalRendering = suppressesIncrementalRendering
        }
        if let allowsInlineMediaPlayback = allowsInlineMediaPlayback {
            webview.allowsInlineMediaPlayback = allowsInlineMediaPlayback
        }
        if let mediaPlaybackRequiresUserAction = mediaPlaybackRequiresUserAction {
            webview.mediaPlaybackRequiresUserAction = mediaPlaybackRequiresUserAction
        }
    }
}
