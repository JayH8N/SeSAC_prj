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

extension UIViewController {
    func convertDateFormat(_ inputDate: String, from inputFormat: String, to outputFormat: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        
        guard let date = inputFormatter.date(from: inputDate) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        return outputFormatter.string(from: date)
    }
}
