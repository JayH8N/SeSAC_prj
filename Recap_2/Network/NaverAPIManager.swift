//
//  NaverAPIManager.swift
//  Recap_2
//
//  Created by hoon on 2023/09/09.
//

import UIKit
import Alamofire

class NaverAPIManager {
    
    static let shared = NaverAPIManager()
    
    private init() { }
    
    let headers: HTTPHeaders = [
        "X-Naver-Client-Id": APIKey.NaverClientID,
        "X-Naver-Client-Secret": APIKey.NaverClientSecret
    ]
    
    //sim:정확도순, date:날짜순, asc:가격낮은순, dsc:가격높은순
    enum Sort {
        case sim, date, asc, dsc
        
        var kindOfSort: String {
            switch self {
            case .sim: return "sim"
            case .date: return "date"
            case .asc: return "asc"
            case .dsc: return "dsc"
            }
        }
    }
    
    func callRequest(keyword: String, sort: Sort ,page: Int, completionHandler: @escaping (Shopping) -> Void) {
        
        let searchWord = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchWord)&display=30&start=\(page)&sort=\(sort.kindOfSort)"
        AF.request(url, method: .get, headers: headers).validate(statusCode: 200...500)
            .responseDecodable(of: Shopping.self) { response in
            switch response.result {
            case .success( _):
                guard let data = response.value else { return }
                
                completionHandler(data)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
