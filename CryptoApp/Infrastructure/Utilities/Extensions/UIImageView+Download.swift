//
//  UIImageView+Download.swift
//  CryptoApp
//
//  Created by Administrator on 21/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

import UIKit
import SVGKit

let imageCache = NSCache<NSString, AnyObject>()

extension SVGKFastImageView {
    func loadImageUsingCache(withUrl urlString: String) {
        let url = URL(string: urlString)
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? SVGKImage {
            self.image = cachedImage
            return
        }

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let image = SVGKImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }

        }).resume()
    }
}
