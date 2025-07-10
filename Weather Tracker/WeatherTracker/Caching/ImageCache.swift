//
//  ImageCache.swift
//  DataParsingAndDisplay
//
//  Created by Anshul Sharma on 11/23/24.
//

import Foundation
import UIKit

public struct ImageCache {
    private var cache = NSCache<NSString, UIImage>()
    
    public init() {
        self.cache.countLimit = 50
    }
    
    public subscript(imageURLString: String) -> UIImage? {
        get {
            return cache.object(forKey: imageURLString as NSString)
        }
        
        set {
            if let newValue = newValue {
                cache.setObject(newValue, forKey: imageURLString as NSString)
            } else {
                cache.removeObject(forKey:  imageURLString as NSString)
            }
        }
    }
}
