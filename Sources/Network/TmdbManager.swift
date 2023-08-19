//
//  TmdbManager.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit
import Alamofire
import SwiftyJSON


class TmdbManager {
    
    static let shared = TmdbManager()
    
    private init() {}
    
    let header: HTTPHeaders = [
        "accept" : "application/json",
        "Authorization" : APIKey.tmdbToken
    ]
    
    func callReqeust(kind: Endpoint, completionHandler: @escaping (TmdbTrending)-> Void) {
        let url = kind.requestURL + "?language=ko-KR"
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: TmdbTrending.self) { response in
                guard let value = response.value else { return }
                
                completionHandler(value)
        }
    }
    
    
    func callGenres(kind: GenreList, completionHandler: @escaping (Genres)-> Void) {
        let url = kind.requestURL
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: Genres.self) { response in
                guard let value = response.value else { return }
                
                completionHandler(value)
        }
    }
    
    func callRequstCast(id: Int, completionHandler: @escaping (Cast) -> ()) {
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits"
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: Cast.self) { response in
                guard let value = response.value else { return }
                
                completionHandler(value)
            }
        }
        
    
    
}
