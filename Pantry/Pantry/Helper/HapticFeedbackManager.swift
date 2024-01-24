//
//  HapticFeedbackManager.swift
//  Pantry
//
//  Created by hoon on 2023/10/19.
//

import UIKit

class HapticFeedbackManager {
    static let shared = HapticFeedbackManager()
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    private init() {
        feedbackGenerator.prepare()
    }
    
    func provideFeedback() {
        feedbackGenerator.impactOccurred()
    }
}
