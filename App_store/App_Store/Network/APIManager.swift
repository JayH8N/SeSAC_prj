//
//  APIManager.swift
//  App_Store
//
//  Created by hoon on 11/6/23.
//

import Foundation
import RxSwift
import RxCocoa


enum APIError: Error {
    case invalidURL
    case unknown
    case statusError
}


class BasicAPIManager {
    
    static let shared = BasicAPIManager()
    
    private init() { }
    
    func fetchData(keyword: String) -> Observable<SearchAppModel> {
        
        return Observable<SearchAppModel>.create { value in
            //서버통신에 대한 응답값
            let text = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let urlString = "https://itunes.apple.com/search?term=\(text)&country=KR&media=software&lang=ko_KR&limit=10"
            
            guard let url = URL(string: urlString) else {
                value.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                print("URLSession Succeed")
                if let _ = error {
                    value.onError(APIError.unknown)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    value.onError(APIError.statusError)
                    return
                }
                
                if let data = data, let appData = try? JSONDecoder().decode(SearchAppModel.self, from: data) {
                    value.onNext(appData)
                }
            }.resume()

            return Disposables.create()
        }
        
    }
    
}
