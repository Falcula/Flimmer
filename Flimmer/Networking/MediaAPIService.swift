//
//  NetworkClient.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-19.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import Foundation

class MediaAPIService {
    
    // Generic network func, pass T :Decodable struct/class to use for the decoding.
    func makeNetworkRequest<T: Decodable>(url: URL, type: T.Type, completionHandler: @escaping (_ error: Error?,_ data: T?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data!)
                completionHandler(nil, decodedData)
            } catch let error {
                completionHandler(error, nil)
                print(error)
                return
            }
            }.resume()
    }
}



