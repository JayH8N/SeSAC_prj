//
//  SeSACAPIManager.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation
import Moya
import RxSwift
import RxCocoa


class SeSACAPIManager {
    static let shared = SeSACAPIManager()
    private init() { }

    private func provider<T: TargetType>() -> MoyaProvider<T> {
        return MoyaProvider<T>()
    }

    func request<U: Decodable, T: TargetType>(_ target: T, decodingType: U.Type, completion: @escaping (Result<U, Error>) -> Void) {
        provider().request(target) { result in
            switch result {
            case .success(let value):
                do {
                    let decodedData = try JSONDecoder().decode(U.self, from: value.data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

//class SeSACAPIManager {
//    static let shared = SeSACAPIManager()
//    private init() { }
//
//    private func provider<T: TargetType>() -> MoyaProvider<T> {
//        return MoyaProvider<T>()
//    }
//
//    func request<U: Decodable, T: TargetType>(_ target: T) -> Single<Result<U, Error>> {
//        return Single.create { single in
//            let cancellable = self.provider().request(target) { result in
//                switch result {
//                case .success(let value):
//                    do {
//                        let decodedData = try JSONDecoder().decode(U.self, from: value.data)
//                        single(.success(.success(decodedData)))
//                    } catch {
//                        single(.success(.failure(error)))
//                    }
//                case .failure(let error):
//                    single(.success(.failure(error)))
//                }
//            }
//
//            return Disposables.create {
//                cancellable.cancel()
//            }
//        }
//    }
//}
