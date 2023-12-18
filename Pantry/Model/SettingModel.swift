//
//  SettingModel.swift
//  Pantry
//
//  Created by hoon on 12/18/23.
//

import Foundation

struct SettingItem {
    let title: String
}

struct SetSettingSection {
    
    init(items: [SettingItem], header: String) {
        self.items = items
        self.header = header
    }
    
    let items: [SettingItem]
    let header: String
    
    static func generateData() -> [SetSettingSection] {
        return [
            SetSettingSection(items: [SettingItem(title: NSLocalizedString(SettingMenu.MenuList.notificationSetting.rawValue, comment: ""))],
                              header: NSLocalizedString(SettingMenu.Header.noti.rawValue, comment: "")),
            SetSettingSection(items: [SettingItem(title: NSLocalizedString(SettingMenu.MenuList.privacyPolicy.rawValue, comment: ""))],
                              header: NSLocalizedString(SettingMenu.Header.termsOfService.rawValue, comment: "")),
            SetSettingSection(items: [SettingItem(title: NSLocalizedString(SettingMenu.MenuList.contactUS.rawValue, comment: "")),
                                      SettingItem(title: NSLocalizedString(SettingMenu.MenuList.openSource.rawValue, comment: "")),
                                      SettingItem(title: NSLocalizedString(SettingMenu.MenuList.appVersion.rawValue, comment: ""))
                                     ], header: NSLocalizedString(SettingMenu.Header.other.rawValue, comment: ""))
        ]
    }
}
