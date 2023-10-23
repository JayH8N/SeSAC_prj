

import Foundation
import Alamofire
import Toast

class BarcodeAPIManager {
    
    static let shared = BarcodeAPIManager()
    
    private init() { }

    
    
    func callRequest(code: String, completionHandler: @escaping (Result<Product, Error>) -> Void) {
        
        let url = "http://openapi.foodsafetykorea.go.kr/api/\(APIKey.barcodeKey)/C005/json/1/1/BAR_CD=\(code)"
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: ProductInfo.self) { response in
            switch response.result {
            case .success(let value):
                let resultCode = value.C005.RESULT.CODE
                if resultCode == "INFO-000" {
                    let product = value.C005.row[0]
                    completionHandler(.success(product))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    
}


