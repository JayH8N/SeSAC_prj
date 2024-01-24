//
//  ReusableViewProtocol.swift
//  SeSAC3Week4
//
//  Created by hoon on 2023/08/11.
//

import UIKit

//프로토콜 이름에 protocol 명시하거나 형용사 보편적으로 씀
protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
