//
//  KakaoAPIManager.swift
//  BookWorm
//
//  Created by hoon on 2023/09/04.
//

import UIKit
import Alamofire


class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    
    private init() {}
    
    let header: HTTPHeaders = [ "Authorization" : "KakaoAK \(APIKey.book)" ]
    
    func callRequest(page: Int, query: String, completionHandler: @escaping (KakaoBook) -> Void) {
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&page=\(page)"
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseDecodable(of: KakaoBook.self ) { response in
            switch response.result{
            case .success(_):
                
                guard let data = response.value else {return}
                print(data)
                completionHandler(data)
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
}
