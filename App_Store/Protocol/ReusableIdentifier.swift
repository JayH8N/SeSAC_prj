//
//  ReusableIdentifier.swift
//  App_Store
//
//  Created by hoon on 11/6/23.
//

import Foundation


protocol ReusableIdentifier {
    static var identifier: String { get }
}


extension SearchViewTableViewCell: ReusableIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension ScreenshotCell: ReusableIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}
