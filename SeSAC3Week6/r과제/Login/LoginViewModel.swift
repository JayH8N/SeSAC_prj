//
//  LoginViewModel.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/09/18.
//

import Foundation


class LoginViewModel {
    
    var email = Observable("")
    var pw = Observable("")
    var nickName = Observable("")
    var location = Observable("")
    var recommendCode = Observable("")
    var isvalid = Observable(false)
    
    
    func checkValidation() {
        if email.value.contains("@") && recommendCode.value.count == 6 && (pw.value.count >= 6 && pw.value.count <= 10) {
            isvalid.value = true
        } else {
            isvalid.value = false
        }
    }
    
}
