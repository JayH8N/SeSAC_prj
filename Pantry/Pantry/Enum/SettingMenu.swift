//
//  SettingMenu.swift
//  Pantry
//
//  Created by hoon on 12/18/23.
//

import Foundation

enum SettingMenu {
    enum Header: String {
        case noti //알림
        case termsOfService //이용약관
        case other //기타
    }
        
    enum MenuList: String {
        case notificationSetting //알림설정
        case privacyPolicy //개인정보처리방침
        case contactUS //문의하기
        case openSource //오픈소스
        case appVersion //앱버전
    }
}
