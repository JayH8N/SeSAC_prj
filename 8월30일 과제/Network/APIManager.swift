//
//  APIManager.swift
//  Diary
//
//  Created by hoon on 2023/08/30.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func callRequest(type: Endpoint, text: String, completionHandler:
                     @escaping (Unsplash) -> Void) {
        let keyword = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = type.callRequest + keyword + "&client_id=\(APIKey.unsplashKey)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500)
            .responseDecodable(of: Unsplash.self) { response in
                switch response.result{
                case .success(_):
                    guard let data = response.value else {return}
                    
                    completionHandler(data)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
