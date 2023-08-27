//
//  TmdbManager.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit
import Alamofire
import SwiftyJSON


class TmdbAPIManager {
    
    static let shared = TmdbAPIManager()
    
    private init() {}
    
    let header: HTTPHeaders = [
        "accept" : "application/json",
        "Authorization" : APIKey.tmdbToken
    ]
    
    func callReqeust(kind: EndpointTrending, page: Int, completionHandler: @escaping (Tmdb)-> Void) {
        let url = kind.requestURL + "?language=en-US&page=\(page)"
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: Tmdb.self) { response in
                switch response.result{
                case .success(_):
                    guard let data = response.value else { return }
                    
                    completionHandler(data)
                    
                case .failure(_):
                    print("Error")
                }
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
    
    func callReqeustTVSeries(kind: TVSeries, completionHandler: @escaping (TVSereis) -> ()) {
        let url = kind.requestURL + "?language=en-US"//"?language=ko-KR"
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: TVSereis.self) { response in
                switch response.result{
                case .success(_):
                    guard let data = response.value else { return }
                    completionHandler(data)
                    
                case .failure(_):
                    print("Error")
                }
            }
    }
    
    
    func callReqeustTVSeries2(kind: TVSeries, id: Int, page: Int, option: TVOption, completionHandler: @escaping (Similar) -> ()) {
        let url = kind.requestURL + "\(id)/\(option.requestURL)?language=en-US&page=\(page)"//"?language=ko-KR"
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: Similar.self) { response in
                switch response.result{
                case .success(_):
                    guard let data = response.value else { return }
                    completionHandler(data)
                    print(data)
                    
                case .failure(_):
                    print("Error")
                }
            }
    }
    

    
        
    
    
}
