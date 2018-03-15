//
//  ImageDetailViewModel.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-26.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import Foundation
import UIKit

class ImageDetailViewModel {
    
    let cacheManager = CacheManager()
    let mediaAPIService = MediaAPIService()
    let mediaHelper = MediaHelper()
    var cacheKey: NSString?
    
    var ImageDetail: Image?
    var ImageData: UIImage?
    
    init(imageDetail : Image, imageData : UIImage) {
        ImageDetail = imageDetail
        ImageData = imageData
    }
    
    func getImageinfo(imageId: String?,completion: @escaping(_ result: Any) -> Void) {
        
        let apipath = "\(MediaHelper.BASE_SERVICE_URL)?method=flickr.photos.getInfo&api_key=\(MediaHelper.API_KEY)&photo_id=\(String(describing: imageId!))&format=json&nojsoncallback=1"
        
        let url = URL(string: apipath)
        self.mediaAPIService.makeNetworkRequest(url: url!, type: ImageDetailRoot.self) { (error, resposeData) in
            
            if let errorUnwrapped = error {
                print(errorUnwrapped.localizedDescription)
            }
            
            if let responseDataUnWrapped = resposeData {
                completion(responseDataUnWrapped)
            }
           
        }
        
    }
}
