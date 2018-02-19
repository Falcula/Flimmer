//
//  Photo.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-19.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import Foundation

class Photo : Codable{
    
    let id: Int
    let title: String
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
    
}
