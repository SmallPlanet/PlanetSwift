//
//  PlanetViewController.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/21/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

public typealias AnchorageAction = ((String, UIView, UIView, UIView?, UIView?, Dictionary<String, Object>) -> Void)

open class PlanetViewController: UIViewController {
    
    open var planetViews = Array<PlanetView>()
    var idMappings = Dictionary<String, Object>()
    @IBInspectable open var titleBundlePath: String?
    open var mainBundlePath: String?
    open var navigationBarHidden = false
    open var persistentViews = false
    open var statusBarStyle:UIStatusBarStyle = .default
    
    open var titleXmlView: View?
    open var mainXmlView: View?
    
    private var anchorageAction:AnchorageAction? = nil
    
    open var safeAreaInsets:UIEdgeInsets {
        get {
            if #available(iOS 11.0, *) {
                if let navController = self.navigationController {
                    return navController.view.safeAreaInsets
                }
                if let window = UIApplication.shared.windows.first {
                    return window.safeAreaInsets
                }
            }
            return UIEdgeInsets.zero
        }
    }
    
    open func reloadViews() {
        if idMappings.count == 0 {
            if let anchorageAction = self.anchorageAction {
                loadView(anchorageAction)
            } else {
                loadView()
            }
        }
    }
    
    open func unloadViews() {
        for child in view.subviews {
            child.removeFromSuperview()
        }
        
        titleXmlView = nil
        mainXmlView = nil
        idMappings.removeAll()
        planetViews.removeAll()
    }
    
    open func loadView(_ anchorage:@escaping AnchorageAction) {
        self.loadView()
        
        self.anchorageAction = anchorage
        
        // we cannot just iterate over the idMappings because the ordering is
        // not garaunteed, therefor we walk over them in XML order
        if let mainXmlView = mainXmlView {
            mainXmlView.visit {
                if let m = ($0 as? View) {
                    if let objectID = m.id {
                        let v = m.view
                        if let p = v.superview {
                            if let idx = p.subviews.firstIndex(of: v) {
                                let prev:UIView? = idx > 0 ? p.subviews[idx-1] : nil
                                let next:UIView? = idx < p.subviews.count-1 ? p.subviews[idx+1] : nil
                                anchorage(objectID, v, p, prev, next, idMappings)
                            } else {
                                anchorage(objectID, v, p, nil, nil, idMappings)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    open override func loadView() {
        super.loadView()
        
        navigationItem.title = self.title
        
        if let titleBundlePath = titleBundlePath, let titleXmlView = PlanetUI.readFromFile(String(bundlePath: titleBundlePath)) as? View {
            navigationItem.titleView = titleXmlView.view
            titleXmlView.visit { $0.gaxbDidPrepare() }
            searchXMLObject(titleXmlView)
            self.titleXmlView = titleXmlView
        }
        
        if let mainBundlePath = mainBundlePath, let mainXmlView = PlanetUI.readFromFile(String(bundlePath: mainBundlePath)) as? View {
            view.addSubview(mainXmlView.view)
            mainXmlView.visit { $0.gaxbDidPrepare() }
            searchXMLObject(mainXmlView)
            self.mainXmlView = mainXmlView
        }
        
        // Overriding loadView because we need a function where the view exists
        // but child view controllers have not been loaded yet
        searchForPlanetView(view)
        for planetView in planetViews {
            if let xmlObj = planetView.xmlView {
                searchXMLObject(xmlObj)
                xmlObj.visit(decorate)
            }
        }
    }
    
    func searchXMLObject(_ xmlObj: Object) {
        xmlObj.visit { [unowned self] (element:GaxbElement) -> () in
            if let xmlController = element as? Controller {
                xmlController.controllerObject = self
            }
            if let xmlObject = element as? Object, let objectId = xmlObject.id {
                self.idMappings[objectId] = xmlObject
            }
        }
    }
    
    open func decorate(_ element: GaxbElement) {
        // Override decorate in your controller class if you need a
        // handle on the XML views from your PlanetView
    }
    
    func searchForPlanetView(_ searchedView:UIView) {
        if let foundView = searchedView as? PlanetView {
            planetViews.append(foundView)
        }
        for child in searchedView.subviews {
            searchForPlanetView(child as UIView)
        }
    }
    
    open func objectForId<T>(_ id:String) -> T? {
        guard let foundObj = idMappings[id] as? T else { return nil }
        return foundObj
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(navigationBarHidden, animated: true)
        self.setNeedsStatusBarAppearanceUpdate()
        
        if persistentViews == false {
            // Reload all views
            reloadViews()
        }
    }
    
    open override var preferredStatusBarStyle : UIStatusBarStyle {
        return statusBarStyle
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        if persistentViews == false {
            // Unload all exisiting views
            unloadViews()
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
}
