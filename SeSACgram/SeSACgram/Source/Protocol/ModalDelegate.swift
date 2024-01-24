//
//  ModalDelegate.swift
//  SeSACgram
//
//  Created by hoon on 11/27/23.
//

import UIKit

@objc protocol ModalDelegate: AnyObject {
    @objc optional func onTapClose()
    @objc optional func presnet()
}
