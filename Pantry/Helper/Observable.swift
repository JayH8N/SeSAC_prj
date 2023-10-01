//
//  Observable.swift
//  Pantry
//
//  Created by hoon on 2023/10/01.
//

import Foundation


class Observable<T> {
    
    
    private var listner: ((T) -> Void)?
    
    var value: T {
        didSet {
            listner?(value) //클로저
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void ) {
        print(#function)
        closure(value)
        listner = closure
    }

    
}
