//
//  PlanetViewController.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/21/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

// swiftlint:disable line_length
// swiftlint:disable cyclomatic_complexity

import UIKit

public typealias AnchorageAction = ((String, UIView, UIView, UIView?, UIView?, [String: Object]) -> Void)

open class PlanetViewController: UIViewController {

    open var planetViews = [PlanetView]()
    var idMappings = [String: Object]()
    @IBInspectable open var titleBundlePath: String?
    open var mainBundlePath: String?
    open var navigationBarHidden = false
    open var persistentViews = false
    open var statusBarStyle: UIStatusBarStyle = .default

    open var titleXmlView: View?
    open var mainXmlView: View?

    private var anchorageAction: AnchorageAction?

    open var safeAreaInsets: UIEdgeInsets {
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

    open func unloadViews() {
        view.removeFromSuperview()

        view = nil
        titleXmlView = nil
        mainXmlView = nil
        idMappings.removeAll()
        planetViews.removeAll()
    }

    open func loadPlanetViews(_ anchorage:@escaping AnchorageAction) {

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

        if self.mainXmlView != nil || self.titleXmlView != nil {
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

        self.anchorageAction = anchorage

        let mirror = Mirror(reflecting: self)
        var validKeys: [String: Bool] = [:]
        for case let (label?, _) in mirror.children {
            validKeys[label] = true
        }

        // we cannot just iterate over the idMappings because the ordering is
        // not garaunteed, therefor we walk over them in XML order
        if let mainXmlView = mainXmlView {
            mainXmlView.visit {
                if let mmm = ($0 as? View) {
                    if let objectID = mmm.id {
                        let view = mmm.view
                        if let parent = view.superview {
                            if let idx = parent.subviews.firstIndex(of: view) {
                                let prev: UIView? = idx > 0 ? parent.subviews[idx-1] : nil
                                let next: UIView? = idx < parent.subviews.count-1 ? parent.subviews[idx+1] : nil
                                if validKeys[objectID] != nil {
                                    setValue(view, forKey: objectID)
                                }
                                anchorage(objectID, view, parent, prev, next, idMappings)
                            } else {
                                if validKeys[objectID] != nil {
                                    setValue(view, forKey: objectID)
                                }
                                anchorage(objectID, view, parent, nil, nil, idMappings)
                            }
                        }
                    }
                }
            }
        }
    }

    func searchXMLObject(_ xmlObj: Object) {
        xmlObj.visit { [unowned self] (element: GaxbElement) -> Void in
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

    func searchForPlanetView(_ searchedView: UIView) {
        if let foundView = searchedView as? PlanetView {
            planetViews.append(foundView)
        }
        for child in searchedView.subviews {
            searchForPlanetView(child as UIView)
        }
    }

    open func objectForId<T>(_ objID: String) -> T? {
        guard let foundObj = idMappings[objID] as? T else { return nil }
        return foundObj
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(navigationBarHidden, animated: true)
        self.setNeedsStatusBarAppearanceUpdate()
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
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
