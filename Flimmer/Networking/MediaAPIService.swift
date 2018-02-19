//
//  NetworkClient.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-19.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import Foundation

class MediaAPIService {
    
    // Execute a call to the API, completionHandler is passback a option response of json.
    func executeAPIRequest(url: URL, completionHandler: @escaping ([String:Any]?, Error?)-> Void){
        
        let sharedSession = URLSession.shared
        let urlRequest =  URLRequest(url: url)
        
        let dataTask = sharedSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            
            guard let unwrappedData = data else {
                completionHandler(nil,error)
                return
            }
        
            do
            {
                let jsonResponse = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String:Any]
                completionHandler(jsonResponse, error)
                
            } catch {
                print(error.localizedDescription)
                completionHandler(nil, error)
            }
            
        }
        
        dataTask.resume()
    }
}
