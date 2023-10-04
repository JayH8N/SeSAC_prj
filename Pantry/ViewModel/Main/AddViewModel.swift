//
//  AddViewModel.swift
//  Pantry
//
//  Created by hoon on 2023/10/03.
//

import Foundation

class AddViewModel {
    
    let repository = RefrigeratorRepository()
    
    var name = Observable("")
    var memo = Observable("")
    var isValid = Observable(false)
    
    
    
    
}
