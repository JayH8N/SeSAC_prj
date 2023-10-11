//
//  ReuseIdentifier.swift
//  Pantry
//
//  Created by hoon on 2023/10/02.
//

import Foundation


protocol ReuseIdentifierProtocol {
    static var identifier: String {get}
}

extension RefrigeratorHeaderView: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}


extension RefrigerCell: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension ItemsCell: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
