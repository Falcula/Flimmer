//
//  ImageDetail.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-03-07.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import Foundation


struct ImageDetailRoot: Decodable {
    let photo: Photo
}

struct Photo: Decodable {
    let server: String
    let owner: owner
    let title: title
}

struct owner: Decodable {
    let realname: String
}

struct title: Decodable {
    let _content: String
}

