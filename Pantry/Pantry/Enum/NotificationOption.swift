//
//  NotificationOption.swift
//  Pantry
//
//  Created by hoon on 2023/10/22.
//

import Foundation

enum NotificationOption: Int, Codable {
    case none
    case oneDayBefore = 1
    case threeDayBefore = 3
    case sevenDayBefore = 7
}
