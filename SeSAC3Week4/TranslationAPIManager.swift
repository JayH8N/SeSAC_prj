//
//  TranslationAPIManager.swift
//  SeSAC3Week4
//
//  Created by hoon on 2023/08/11.
//

import Foundation
import SwiftyJSON
import Alamofire

class TranslateAPIManger {
    static let shared = TranslateAPIManger()
    
    private init() {}
    
    func callRequest(text: String, resultString: @escaping (String) -> Void) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverClientID,
            "X-Naver-Client-Secret": APIKey.naverCliendSecret
        ]
        let parameters: Parameters = [
            "source": "ko",
            "target": "en",
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let data = json["message"]["result"]["translatedText"].stringValue
                resultString(data)
                
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
}
