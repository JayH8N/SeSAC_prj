//
//  LocalNotificationManager.swift
//  Pantry
//
//  Created by hoon on 2023/10/22.
//

import UserNotifications

class LocalNotificationManager {
    static let shared = LocalNotificationManager()
    
    private init() { }
    
    private let userDefaults = UserDefaults.standard
    
    //딕셔너리로 관리 => 중복되면 덮어쓰기 되도록!
    private var infoList: [String: NotificationOption] {
        get {
            if let data = userDefaults.value(forKey: "infoList") as? Data,
               let infoList = try? JSONDecoder().decode([String: NotificationOption].self, from: data) {
                return infoList
            }
            return [:]
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                userDefaults.set(data, forKey: "infoList")
            }
        }
    }
    
    func saveAlarmInfo(identifier: String, notification: NotificationOption) {
        var updatedInfoList = infoList
        updatedInfoList[identifier] = notification
        infoList = updatedInfoList
    }
    
    func readAlarmInfo(identifier: String) -> NotificationOption {
        return infoList[identifier] ?? .none
    }
    
    
    //알람 등록
    func createNotification(item: Items, notificationDay: NotificationOption) {
        if notificationDay == .none {
            removeNotification(item: item)
            saveAlarmInfo(identifier: "\(item._id)", notification: .none)
            return
        }
        
        let center = UNUserNotificationCenter.current()
        
        // 이미 존재하는 알람삭제
        let identifier = "\(item._id)"
        removeNotification(item: item)
        saveAlarmInfo(identifier: identifier, notification: notificationDay)
        
        
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("ExpNoti", comment: "") //"유통기한 알림"
        content.body = String(format: NSLocalizedString("ExpNotiBody", comment: ""), item.name, notificationDay.rawValue)
        
        var triggerDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: item.expiryDay)
        triggerDateComponents.hour = 18 // 오후 6시 고정
        triggerDateComponents.minute = 0
        
        if let triggerDate = Calendar.current.date(from: triggerDateComponents) {
            let calculatedTriggerDate = Calendar.current.date(byAdding: .day, value: -notificationDay.rawValue, to: triggerDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: calculatedTriggerDate ?? triggerDate), repeats: false)
            
            let request = UNNotificationRequest(identifier: "\(item._id)", content: content, trigger: trigger)
            
            center.add(request) { error in
                if let error = error {
                    print("Error=======: \(error)")
                } else {
                    print("알람 등록 성공!!!!==========제발제발===")
                }
            }
        }
    }
    
    
    //알람 삭제
    //존재하지 않는 identifier할당해도 오류나지는 않음!
    func removeNotification(item: Items) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(item._id)"]) //발생하지 않은 알림 삭제
        center.removeDeliveredNotifications(withIdentifiers: ["\(item._id)"]) // 이미 발생한 알림 삭제
        
    }
}


