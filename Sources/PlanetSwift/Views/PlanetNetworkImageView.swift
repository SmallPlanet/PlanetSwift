//
//  PlanetNetworkImageView.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/20/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

public class PlanetNetworkImageView: UIImageView {

    public var placeholderContentMode: UIView.ContentMode = .scaleToFill
    public var downloadedContentMode: UIView.ContentMode = .scaleToFill

    public func setImageWithPath(_ path: String?,
                                 placeholder: UIImage? = nil,
                                 completion: ((_ success: Bool) -> Void)? = nil) {
        guard let urlPath = path, let url = NSURL(string: urlPath) else {
            setImage(nil, placeholder: placeholder, completion: completion)
            return
        }

        setImage(url as URL, placeholder: placeholder, completion: completion)
    }

    public func setImage(_ imageUrl: URL?,
                         placeholder: UIImage? = nil,
                         completion: ((_ success: Bool) -> Void)? = nil) {
        contentMode = placeholderContentMode
        image = placeholder

        guard let imageUrl = imageUrl else {
            completion?(false)
            return
        }

        ImageCache.sharedInstance.get(imageUrl) { [weak self] (image: UIImage?) in
            if let image = image {
                if let downloadedContentMode = self?.downloadedContentMode {
                    self?.contentMode = downloadedContentMode
                }
                self?.image = image
                completion?(true)
            } else {
                completion?(false)
            }
        }
    }

}
