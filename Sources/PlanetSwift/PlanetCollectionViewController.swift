//
//  PlanetCollectionViewController.swift
//  Planned
//
//  Created by Quinn McHenry on 12/2/15.
//  Copyright (c) 2015 Small Planet Digital. All rights reserved.
//

// swiftlint:disable line_length
// swiftlint:disable force_cast

import UIKit

public protocol PlanetCollectionViewTemplate {
    var reuseId: String { get }
    var size: TemplateSize { get }
    func decorate(_ cell: UICollectionViewCell)
}

public typealias TemplateSize = (width: TemplateConstraint, height: TemplateConstraint)

public enum TemplateConstraint {
    case unconstrained
    case full
    case half
    case fixed(points: Float)
}

public func == (lhs: TemplateConstraint, rhs: TemplateConstraint) -> Bool {
    switch (lhs, rhs) {
    case (.unconstrained, .unconstrained): return true
    case (.full, .full): return true
    case (.half, .half): return true
    case (.fixed(let aaa), .fixed(let bbb))   where aaa == bbb: return true
    default: return false
    }
}

public func != (lhs: TemplateConstraint, rhs: TemplateConstraint) -> Bool {
    return !(lhs == rhs)
}

public func == (lhs: TemplateSize, rhs: TemplateSize) -> Bool {
    return lhs.width == rhs.width && lhs.height == rhs.height
}

public func != (lhs: TemplateSize, rhs: TemplateSize) -> Bool {
    return !(lhs == rhs)
}

public protocol PlanetCollectionViewCell: class {
    var bundlePath: String { get }
    var xmlView: View? { get set }
    func loadView()
}

public extension PlanetCollectionViewCell where Self: UICollectionViewCell {

    func loadView() {
        guard xmlView == nil else { return }
        xmlView = PlanetUI.readFromFile(String(bundlePath: bundlePath)) as? View
        guard let xmlView = xmlView else {
            // failed to create xml view from bundlePath \(bundlePath)
            return
        }
        contentView.addSubview(xmlView.view)
        xmlView.visit { $0.gaxbDidPrepare() }

        let mirror = Mirror(reflecting: self)
        for case let (label?, _) in mirror.children {
            if let element = xmlView.elementForId(label) as? View {
                setValue(element.view, forKey: label)
            }
        }

        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: contentView, equalAttribute: .width))
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: contentView, equalAttribute: .height))
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: contentView, equalAttribute: .left))
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: contentView, equalAttribute: .top))
        xmlView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        addConstraint(NSLayoutConstraint(item: self, toItem: contentView, equalAttribute: .width))
        addConstraint(NSLayoutConstraint(item: self, toItem: contentView, equalAttribute: .height))
        addConstraint(NSLayoutConstraint(item: self, toItem: contentView, equalAttribute: .left))
        addConstraint(NSLayoutConstraint(item: self, toItem: contentView, equalAttribute: .top))
    }
}

public extension PlanetCollectionViewCell where Self: UICollectionReusableView {

    func loadView() {
        guard xmlView == nil else { return }
        xmlView = PlanetUI.readFromFile(String(bundlePath: bundlePath)) as? View
        guard let xmlView = xmlView else {
            // failed to create xml view from bundlePath \(bundlePath)
            return
        }
        addSubview(xmlView.view)
        xmlView.visit { $0.gaxbDidPrepare() }

        let mirror = Mirror(reflecting: self)
        for case let (label?, _) in mirror.children {
            if let element = xmlView.elementForId(label) as? View {
                setValue(element.view, forKey: label)
            }
        }

        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: self, equalAttribute: .width))
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: self, equalAttribute: .height))
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: self, equalAttribute: .left))
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: self, equalAttribute: .top))
        xmlView.view.translatesAutoresizingMaskIntoConstraints = false
    }
}

open class PlanetCollectionViewController: PlanetViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet open var collectionView: UICollectionView!
    open var cellReferences = [String: PlanetCollectionViewCell]()
    open var cellMapping: [String: PlanetCollectionViewCell.Type] { return [:] }
    open var cellSizes: [[CGSize]] = []
    open var objects: [[PlanetCollectionViewTemplate]] = [] {
        didSet {
            cellSizes.removeAll(keepingCapacity: false)
            for subarray in objects {
                cellSizes.append([CGSize](repeating: CGSize.zero, count: subarray.count))
            }
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        collectionView.contentOffset = CGPoint.zero
    }

    open func configureCollectionView() {
        for (cellId, cellClass) in cellMapping {
            collectionView?.register(cellClass, forCellWithReuseIdentifier: cellId)
        }

        if collectionView?.collectionViewLayout == nil {
            collectionView?.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
        }
    }

    // MARK: - Collection View Cell Handling

    open func configure(_ cell: PlanetCollectionViewCell?, atIndexPath indexPath: IndexPath) {
        guard cell?.xmlView == nil else { return } // only configure each cell once

        cell?.loadView()
        guard let xmlView = cell?.xmlView,
            let template = cellObject(indexPath as IndexPath),
            let cell = cell as? UICollectionViewCell
            else { return }

        switch template.size.width {
        case .unconstrained: break
        case .full:
            let insets = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAt: indexPath.section)
            let constraint = NSLayoutConstraint(item: xmlView.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: collectionView.frame.size.width - insets.left - insets.right)
            xmlView.view.addConstraint(constraint)
        case .half:
            let insets = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAt: indexPath.section)
            let constant = (collectionView.frame.size.width - insets.left - insets.right - max(insets.right, insets.left)) / 2
            let constraint = NSLayoutConstraint(item: xmlView.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: floor(constant))
            xmlView.view.addConstraint(constraint)
        case .fixed(let points):
            let constraint = NSLayoutConstraint(item: xmlView.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: CGFloat(points))
            xmlView.view.addConstraint(constraint)
        }

        switch template.size.height {
        case .unconstrained: break
        case .full:
            let insets = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAt: indexPath.section)
            let constraint = NSLayoutConstraint(item: xmlView.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: collectionView.frame.size.height - insets.top - insets.bottom)
            xmlView.view.addConstraint(constraint)
        case .half:
            break
        case .fixed(let points):
            let constraint = NSLayoutConstraint(item: xmlView.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: CGFloat(points))
            xmlView.view.addConstraint(constraint)
        }
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
    }

    open func cellMapping(_ reuseId: String) -> PlanetCollectionViewCell.Type? {
        return cellMapping[reuseId]
    }

    open func reuseIdentifier(_ indexPath: IndexPath) -> String {
        return cellObject(indexPath)?.reuseId ?? "invalidReuseId"
    }

    open func cellObject(_ indexPath: IndexPath) -> PlanetCollectionViewTemplate? {
        guard objects.count > indexPath.section && objects[indexPath.section].count > indexPath.row else { return nil }
        return objects[indexPath.section][indexPath.row]
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    open func cellSize(_ indexPath: IndexPath) -> CGSize? {
        guard cellSizes.count > indexPath.section && cellSizes[indexPath.section].count > indexPath.row else { return nil }
        return cellSizes[indexPath.section][indexPath.row]
    }

    open func setCellSize(_ size: CGSize, forIndexPath indexPath: IndexPath) {
        guard cellSizes.count > indexPath.section && cellSizes[indexPath.section].count > indexPath.row else { return }
        cellSizes[indexPath.section][indexPath.row] = size
    }

    open func cellHeight(_ indexPath: IndexPath) -> CGFloat? {
        return (cellSize(indexPath) ?? CGSize.zero).height
    }

    open func setCellHeight(_ height: CGFloat, forIndexPath indexPath: IndexPath) {
        if let size = cellSize(indexPath) {
            setCellSize(CGSize(width: size.width, height: height), forIndexPath: indexPath)
        }
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = cellSize(indexPath) ?? CGSize.zero
        if let template = cellObject(indexPath), size == CGSize.zero {
            let reuseId = reuseIdentifier(indexPath)

            var cellReference: PlanetCollectionViewCell? = cellReferences[reuseId]
            if cellReference == nil {
                if let cellReferenceType = cellMapping(reuseId) as? UICollectionViewCell.Type {
                    cellReference = cellReferenceType.init() as? PlanetCollectionViewCell
                }
                if cellReference == nil {
                    assertionFailure("Could not create cell from reuseId \"\(reuseId)\"")
                    return CGSize.zero
                }
                configure(cellReference!, atIndexPath: indexPath)
                cellReferences[reuseId] = cellReference
            }
            configure(cellReference!, atIndexPath: indexPath)
            template.decorate(cellReference as! UICollectionViewCell)

            let xmlView = cellReference?.xmlView
            size = xmlView?.view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize) ?? CGSize.zero
            setCellSize(size, forIndexPath: indexPath)
        }
        return size
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: section == 0 ? 64 : 0, left: 0, bottom: 0, right: 0)
    }

    public init(frame: CGRect) {
        super.init(nibName: nil, bundle: nil)
        let cvv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        cvv.delegate = self
        cvv.dataSource = self
        self.collectionView = cvv
        self.view = cvv
        self.configureCollectionView()
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension PlanetCollectionViewController: UICollectionViewDataSource {

    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return objects.count
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects[section].count
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier(indexPath), for: indexPath)
        configure(cell as? PlanetCollectionViewCell, atIndexPath: indexPath)
        cellObject(indexPath)?.decorate(cell)
        return cell
    }

    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "", for: indexPath)
        return cell
    }
}

extension PlanetCollectionViewController: UICollectionViewDelegate {

    open func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.isHighlighted = true
    }

    open func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.isHighlighted = false
    }

    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
