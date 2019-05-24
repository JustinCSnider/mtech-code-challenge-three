//
//  NetworkController.swift
//  mtech-coding-challenge-three
//
//  Created by Justin Snider on 5/20/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation

struct NetworkController {
    
    static let omdbURLString = "https://www.omdbapi.com/?i=tt3896198&apikey=92a3b4cb"
    
    static func performNetworkRequest(for url: URL, accessToken: String?, completion: ((Data?, Error?) -> Void)? = nil) {
        
        var request = URLRequest(url: url)
        
        if let accessToken = accessToken {
            request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let completion = completion {
                
                completion(data, error)
            }
        }
        dataTask.resume()
    }
}
