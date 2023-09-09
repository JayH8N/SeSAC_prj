//
//  Enum+API.swift
//  Recap_2
//
//  Created by hoon on 2023/09/09.
//

//import UIKit
//
//
//enum API {
//    case sim, date, asc ,dsc
//
//    func callRequest() {
//        switch self {
//        case .sim: callSim(keyword: <#T##String#>)
//        case .date: callDate()
//        case .asc: callAsc()
//        case .dsc: callDsc()
//        }
//    }
//
//
//
//    private func callSim(keyword: String) {
//        NaverAPIManager.shared.callRequest(keyword: keyword, sort: .sim, page: 1) { data in
//            <#code#>
//        }
//    }
//
//    private func callDate(keyword: String) {
//        NaverAPIManager.shared.callRequest(keyword: keyword, sort: .date, page: 1, completionHandler: <#T##(Shopping) -> Void#>)
//    }
//
//    private func callAsc(keyword: String) {
//        NaverAPIManager.shared.callRequest(keyword: keyword, sort: .asc, page: 1, completionHandler: <#T##(Shopping) -> Void#>)
//    }
//
//    private func callDsc(keyword: String) {
//        NaverAPIManager.shared.callRequest(keyword: keyword, sort: .dsc, page: 1, completionHandler: <#T##(Shopping) -> Void#>)
//    }
//}
