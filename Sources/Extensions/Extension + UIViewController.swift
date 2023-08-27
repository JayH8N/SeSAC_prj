//
//  Extension + UIViewController.swift
//  Media
//
//  Created by hoon on 2023/08/27.
//

import UIKit

extension UIViewController: Reusableidentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
