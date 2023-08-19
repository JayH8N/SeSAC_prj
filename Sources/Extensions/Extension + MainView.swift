//
//  Extension + MainView.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit

extension MainViewController: Reusableidentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
