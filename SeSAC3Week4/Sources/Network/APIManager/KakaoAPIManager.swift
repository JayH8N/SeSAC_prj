//
//  KakaoAPIManager.swift
//  SeSAC3Week4
//
//  Created by hoon on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    
    private init() {}
    
    let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakaoAPIKey)"] //카카오가 공통으로 사용해서 함수내에 작성하지 않고 class프로퍼티로 사용
    
    func callRequest(type: Endpoint, query: String, page: Int, completionHandler: @escaping (KakaoVideo) -> () ) {
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = type.requestURL + text + "&page=\(page)"
        
        print(url)
        //직접 기입했을 때 오류가 안났는데 상수로 빼서 기입하니 오류가 난다. --> 타입을 맞게 해준다. HTTPHeaders
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseDecodable(of: KakaoVideo.self ) { response in
            
            guard let value = response.value else { return }
            
            completionHandler(value)
        }
    }
    
}
