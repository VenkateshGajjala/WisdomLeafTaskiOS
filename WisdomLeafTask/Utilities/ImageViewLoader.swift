//
//  ImageViewLoader.swift
//  WisdomLeafTask
//
//  Created by Venkatesh on 24/08/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()

class ImageViewLoader:UIImageView{
    var imageLink: URL?
    // Taking Activity Indiator for loading till download image
    let activityIndicator = UIActivityIndicatorView()
    func loadImage(_ url:URL){
        activityIndicator.color = .darkGray
        addSubview(activityIndicator) // adding to ImageView
        // adding constrains to activityIndicator for fitting inside Imageview
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false // for allowing to take constraint
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageLink = url

        self.image = nil
        activityIndicator.startAnimating()

        // chcek image url already stored in cache, if not create
        if let cacheImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = cacheImage
            activityIndicator.stopAnimating()
            return
        }
        
        // downloading image using URLSession
        let shared = URLSession.shared
        shared.dataTask(with: url, completionHandler:  { (data, response, error) in
            if error != nil {
                // when image url is wrong, timeout or not available
                print("ERROR = \(error as Any)")
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
                return
            }
            // If image successfully downloaded
            DispatchQueue.main.async(execute: {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self.imageLink == url {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
