//
//  PushableTransition.swift
//  SeSACgram
//
//  Created by hoon on 11/28/23.
//

import UIKit

protocol PushableTransition: AnyObject {
    func push(vc: UIViewController)
}
