//
//  SwitchScreen.swift
//  Pantry
//
//  Created by hoon on 2023/10/12.
//

import UIKit
import YPImagePicker

protocol SwitchScreenProtocol: AnyObject {
    func switchScreen(nav: UINavigationController)
}

protocol YPImagePickerProtocol: AnyObject {
    func presentImagePicker(picker: YPImagePicker)
}
