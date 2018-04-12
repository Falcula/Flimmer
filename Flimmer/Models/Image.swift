//
//  Photo.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-19.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import Foundation
import UIKit


struct ImageRoot: Decodable {
    let data: Images
    
    enum CodingKeys: String, CodingKey {
        case data = "photos"
    }
}

struct Images: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [Image]
}

struct Image: Decodable {
    let id: String
    let title: String
    let secret: String
    let server: String
    let farm: Int
    let owner: String
}




