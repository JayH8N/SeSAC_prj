//
//  Extension + CastTableViewCell.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit

extension CastTableViewCell: Reusableidentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

