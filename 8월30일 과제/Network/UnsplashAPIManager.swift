//
//  UnsplashAPIManager.swift
//  PhotoGram
//
//  Created by hoon on 2023/09/02.
//

import UIKit

class UnsplashAPIManager {
    
    
    static let shared = UnsplashAPIManager()
    
    private init() {}
    
    func callRequest(type: Endpoint, keyword: String, completionHandler: @escaping (Photo?) -> Void) {
        
        guard let url = URL(string: type.callRequest + keyword + "&client_id=\(APIKey.unsplashKey)") else { return }
        
        let request = URLRequest(url: url, timeoutInterval: 10)
        
        
        //global쓰레드
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                //에러부터 대응한다., 에러가 nil이면 통신성공, nil이 아니라면 통신 실패를 의미
                if let error {
                    completionHandler(nil)
                    print(error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,(200...500).contains(response.statusCode) else {
                    completionHandler(nil)
                    print(error)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    completionHandler(result)
                    print(result)
                } catch {
                    print(error)
                }
            }
            
           

        }.resume()
        
    }
    
    
}


