//
//  ImageCollectionViewModel.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-20.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ImageCollectionViewModel {
    
    let mediaAPIService = MediaAPIService()
    let cacheManager = CacheManager()
    
    var images: [Image] = []
    
    func loadImages(query: String?, location: CLLocationCoordinate2D?, completion: @escaping() -> Void) {
        
        var searchQuery: String = ""
        if let query = query {
            searchQuery = query
        }
        
        let encodedQuery = searchQuery.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlFragmentAllowed)

        var apipath = "\(MediaHelper.BASE_SERVICE_URL)?method=flickr.photos.search&api_key=\(MediaHelper.API_KEY)&tags=%22+%22&safe_search=3&text=\(encodedQuery!)&format=json&nojsoncallback=1&per_page=100"
        
        // If search by location, extend url.
        if let location = location {
            apipath.append("&lat=\(location.latitude)&lon=\(location.longitude)&radius=1")
        }
       
        let url = URL(string: apipath)
        self.mediaAPIService.makeNetworkRequest(url: url!, type: ImageRoot.self) { (error, resposeData) in
            
            if let errorUnwrapped = error {
                print(errorUnwrapped.localizedDescription)
            }
            
            if let responseDataUnWrapped = resposeData {
                self.images = responseDataUnWrapped.data.photo
                completion()
            }
            
        }
    }
    
    
    func getImage(index: Int,completion: @escaping(_ result: UIImage) -> Void) {
        let cacheKey = self.images[index].id as NSString;
        
        // Check if image is stored in NSCache, otherwise download in background thread and add to cache.
        if let cachedImage = self.cacheManager.getFromCache(key: cacheKey){
            DispatchQueue.main.async {
                completion((cachedImage as? UIImage)!)
            }
        }
        else {
            DispatchQueue.global().async {
                if let imageUrl = MediaHelper.generateImageURL(data: self.images[index]) {
                    let imageData = NSData(contentsOf: imageUrl)
                    DispatchQueue.main.async {
                        completion(UIImage(data: imageData! as Data)!)
                        self.cacheManager.addToCache(key: cacheKey, object: UIImage(data: imageData! as Data)!)
                    }
                }
            }
        }
    }
    
    
}
