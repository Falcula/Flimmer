//
//  MediaHelper.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-20.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import Foundation 

class MediaHelper {
    
    static func generateImageURL(data : Image) -> URL? {
        let resURL = URL(string: "https://farm\(String(describing: data.farm)).staticflickr.com/\(String(describing: data.server))/\(String(describing: data.id))_\(String(describing: data.secret))_m.jpg")
        return resURL!;
    }
    
}
