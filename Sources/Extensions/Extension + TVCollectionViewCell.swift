//
//  Extension + TVCollectionViewCell.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit

extension TVCollectionViewCell: Reusableidentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
