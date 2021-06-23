//
//  UIImageViewExtensions.swift
//  CompositionLayoutExample
//
//  Created by Firat Tamur on 6/23/21.
//

import UIKit

let cachedImages = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil
        
        // check cache for image first
        if let cacheImage = cachedImages.object(forKey: urlString as NSString) {
            
            print("Fetching profile image from cache...")
            self.image = cacheImage
            return
            
        }
        
        // otherwise fireoff a new download
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { data, resp, err in
            
            if err != nil {
                print(err!)
                return
            }
            
            DispatchQueue.main.async {
                if let newImage = UIImage(data: data!) {
                    cachedImages.setObject(newImage, forKey: urlString as NSString)
                    self.image = newImage
                }
            }
            
        })
        
        task.resume()
        
    }
    
}
        
