//
//  ReusableIdentifier.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit

protocol ReusableIdentifier {
    static var identifier: String { get }
}

extension FilterCell: ReusableIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}
