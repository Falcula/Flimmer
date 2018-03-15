//
//  MediaHelper.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-20.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import Foundation 

class MediaHelper { 
    
    // Maybe we should store this info in another place maybe info.plist?
    static let BASE_SERVICE_URL = "https://api.flickr.com/services/rest/"
    static let API_KEY = "9e3c545c766bcd062ae0dad49fe294fb"
    
    static func generateImageURL(data : Image) -> URL? {
        let resURL = URL(string: "https://farm\(String(describing: data.farm)).staticflickr.com/\(String(describing: data.server))/\(String(describing: data.id))_\(String(describing: data.secret))_z.jpg")
        return resURL!;
    }
    
}
