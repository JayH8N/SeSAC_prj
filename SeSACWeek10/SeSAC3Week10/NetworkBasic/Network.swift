//
//  Network.swift
//  SeSAC3Week10
//
//  Created by hoon on 2023/09/19.
//

import Foundation
import Alamofire

class Network {
    
    static let shared = Network()
    
    private init() { }
    
    func requestConvertible<T: Decodable>(type: T.Type, api: Router, completion: @escaping (Result<T, SeSACError>) -> Void) {
        
        AF.request(api).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
    
    func request<T: Decodable>(type: T.Type, api: SeSACAPI, completion: @escaping (Result<T, SeSACError>) -> Void) {
        
        AF.request(api.endPoint, method: api.method, parameters: api.qeury, encoding: URLEncoding(destination: .queryString), headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
}
