//
//  UIResponder.swift
//  Pantry
//
//  Created by hoon on 2023/10/16.
//

import UIKit

extension UIResponder {
    
    private struct Static {
           static weak var responder: UIResponder?
       }
       
       static var currentResponder: UIResponder? {
           Static.responder = nil
           UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
           return Static.responder
       }
       
       @objc private func _trap() {
           Static.responder = self
       }
    
}
