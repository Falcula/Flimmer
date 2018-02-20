//
//  CacheManager.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-20.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import Foundation

class CacheManager {
    
    var cache = NSCache<NSString,AnyObject>()
    
    func addToCache(key:NSString, object: AnyObject) {
        cache.setObject(object, forKey: key)
    }
    
    func getFromCache(key:NSString)->AnyObject? {
        return cache.object(forKey: key)
    }
    
    func existInCache(key:NSString) ->Bool {
        return getFromCache(key: key) != nil
    }
    
    
}
