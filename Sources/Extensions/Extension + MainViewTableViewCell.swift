//
//  Extension + MainViewTableViewCell.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit

extension MainViewTableViewCell: Reusableidentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
