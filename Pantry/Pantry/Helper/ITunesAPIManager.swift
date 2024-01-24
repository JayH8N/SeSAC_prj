//
//  ITunesAPIManager.swift
//  Pantry
//
//  Created by hoon on 12/19/23.
//

import Foundation
import Alamofire
import SwiftyJSON

final class ITunesAPIManager {
    
    static let shared = ITunesAPIManager()
    private init() { }
    
    
    func getLatestAppVersion(completion: @escaping (String) -> Void) {
        let bundleID = "com.junghoon.Pantrytest"
        let appStoreUrl = "http://itunes.apple.com/kr/lookup?bundleId=\(bundleID)"
        
        AF.request(appStoreUrl, method: .get)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    let data = json["results"][0]["version"].stringValue
                    completion(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
