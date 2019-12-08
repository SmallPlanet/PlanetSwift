//
// Autogenerated by gaxb at 04:18:05 PM on 04/29/15
//

import UIKit

public class ScrollView: ScrollViewBase {
	lazy public var scrollView = UIScrollView(frame: CGRect.zero)
	override open var view: UIView {
		get {
			return scrollView
		}
		set {
			if let newValue = newValue as? UIScrollView {
				scrollView = newValue
			}
		}
	}
	
	open override func gaxbPrepare() {
		super.gaxbPrepare()
		
		if let contentSize = contentSize {
			scrollView.contentSize = contentSize
		}
        #if os(iOS)
		if let pagingEnabled = pagingEnabled {
			scrollView.isPagingEnabled = pagingEnabled
		}
        #endif
		if let showsHorizontalScrollIndicator = showsHorizontalScrollIndicator {
			scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
		}
		if let showsVerticalScrollIndicator = showsVerticalScrollIndicator {
			scrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
		}
	}
}
