//
//  HapticManager.swift
//  SeSACgram
//
//  Created by hoon on 11/13/23.
//

import UIKit

final class HapticManager {
    static let shared = HapticManager()
    
    private init() { }
    
    func viberatorForNotification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
    
    func viberateForInteraction(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
