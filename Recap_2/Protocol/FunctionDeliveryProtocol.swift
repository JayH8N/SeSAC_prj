//
//  FunctionDeliveryProtocol.swift
//  Recap_2
//
//  Created by hoon on 2023/09/11.
//

import UIKit

@objc protocol FunctionDeliveryProtocol: AnyObject {
    @objc optional func didselectItemAt(vc: UIViewController)
    @objc optional func showAlert(title: String)
}
