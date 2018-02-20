//
//  ImageCollectionViewModel.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-20.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import Foundation
import UIKit

class ImageCollectionViewModel {
    
    let mediaAPIService = MediaAPIService()
    let cacheManager = CacheManager()
    
    var images: [Image] = []
    
    
    var myImages : [Image] {
        return self.images;
    }
    
    func loadImages(completion: @escaping([Image]) -> Void) {
      
        //TODO: PUT IN OTHER LOCATION
        let apipath = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=387fe5e3442fd10b79e33362e5cfc220&format=json&nojsoncallback=1&auth_token=72157691930598591-42f4859ccf389479&api_sig=3d011e2d54519bddeab629512e3e9f88"
        
        let url = URL(string: apipath)
        self.mediaAPIService.makeNetworkRequest(url: url!, type: ImageRoot.self) { (error, resposeData) in
            
                if let errorUnwrapped = error {
                    print(errorUnwrapped.localizedDescription)
                }
                
                if let responseDataUnWrapped = resposeData {
                    self.images = responseDataUnWrapped.data.photo
                    completion(self.images)
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
                        //cell.ImageView.image = UIImage(data: imageData! as Data)
                        completion(UIImage(data: imageData! as Data)!)
                        self.cacheManager.addToCache(key: cacheKey, object: UIImage(data: imageData! as Data)!)
                    }
                }
            }
        }
    }
    
    
}
