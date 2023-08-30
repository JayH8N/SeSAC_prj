//
//  APIService.swift
//  Diary
//
//  Created by hoon on 2023/08/30.
//

import Foundation

class APIServie {
    
    static let shared = APIServie()
    
    private init() {}
    
    func callRequest() {
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(data)
            
            let value = String(data: data!, encoding: .utf8)
            print(value)
            print(response)
            print(error)
        }.resume()
        
    }
    
    
    
    
}
