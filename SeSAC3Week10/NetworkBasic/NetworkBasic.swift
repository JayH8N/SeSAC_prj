//
//  NetworkBasic.swift
//  SeSAC3Week10
//
//  Created by hoon on 2023/09/19.
//

import Foundation
import Alamofire

enum SeSACError: Int, Error, LocalizedError {
    case unAuthorized = 401
    case permisstionDenied = 403
    case invalidServer = 500
    case missingParameter = 400
    
    var errorDescription: String {
        switch self {
        case .unAuthorized:
            return "인증 정보가 없습니다"
        case .permisstionDenied:
            return "권한이 없습니다"
        case .invalidServer:
            return "서버 점검 중입니다"
        case .missingParameter:
            return "검색어를 입력해주세요"
        }
    }
}


//최종 상속, 컴파일 타임
final class NetworkBasic {
    
    static let shared = NetworkBasic()
    
    private init() { }
    
    
    ///Search Photo
    //func request(query: String, completion: @escaping (Photo?, Error?) -> Void) => 옵셔널인 이유 : 매개변수로 성공시와 에러시를 받아오기 때문에 둘 중 하나는 무조건
    func request(api: SeSACAPI, completion: @escaping (Result<Photo, SeSACError>) -> Void) { //=> 기존 옵셔널일 경우 논리적으로 둘다 nil값이 오거나, 둘다 nil값이 아닐 수 있기에 경우의 수를 줄여줄 수 있는 Result타입을 사용한다.
        
        //let query: Parameters = ["query": query] //보통은 .get이 아니라 .post일때 사용 => .get에서 사용한다면 에러(encoding이용해서 사용해야된다)
        
        //method굳이 안써도 .get이 default값으로 지정되어있음
        AF.request(api.endPoint, method: api.method, parameters: api.qeury, encoding: URLEncoding(destination: .queryString), headers: api.header).responseDecodable(of: Photo.self) { response in
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
    
    
    ///Random Photo
    func random(api: SeSACAPI , completion: @escaping (Result<PhotoResult, SeSACError>) -> Void) {
       
        //method굳이 안써도 .get이 default값으로 지정되어있음
        AF.request(api.endPoint, method: api.method, headers: api.header).responseDecodable(of: PhotoResult.self) { response in
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
    
    
    ///Get a Photo
    func detailPhoto(api: SeSACAPI, id: String, completion: @escaping (Result<PhotoResult, SeSACError>) -> Void ) {  //"wExSfWSHNwA"
        
        //method굳이 안써도 .get이 default값으로 지정되어있음
        AF.request(api.endPoint, method: api.method, headers: api.header).responseDecodable(of: PhotoResult.self) { response in
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
