//
//  SearchViewModel.swift
//  App_Store
//
//  Created by hoon on 11/6/23.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    
    let appLists = PublishSubject<[AppInfo]>()
    let disposeBag = DisposeBag()
    
}
