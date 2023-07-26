//
//  StatisticsViewController.swift
//  EmotionCounter
//
//  Created by hoon on 2023/07/25.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    let backColor: [UIColor] = [.systemPink, .yellow, .systemYellow, .systemBlue, .cyan]
    let labelColor: [UIColor] = [.white, .black, .black, .black, .white]
    let leftLabelText = ["완전행복지수", "적당미소지수", "그냥그냥지수", "좀속상한 지수", "많이슬픈지수"]
    
    
    @IBOutlet var views: [UIView]!
    @IBOutlet var rightLabel: [UILabel]!
    @IBOutlet var leftLabel: [UILabel]!
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setLabel()
    
        result()
        
    }
    //MARK: -
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        result()
    }
    
    
    
    
    func result() {
        
        rightLabel[0].text = String(userDefaults.integer(forKey: forKey.first.rawValue))
        rightLabel[1].text = String(userDefaults.integer(forKey: forKey.second.rawValue))
        rightLabel[2].text = String(userDefaults.integer(forKey: forKey.third.rawValue))
        rightLabel[3].text = String(userDefaults.integer(forKey: forKey.fourth.rawValue))
        rightLabel[4].text = String(userDefaults.integer(forKey: forKey.fifth.rawValue))
    }
    
    
    
    
    
    func setViews() {
        for i in 0...views.count - 1 {
            views[i].layer.cornerRadius = 5
            views[i].backgroundColor = backColor[i]
        }
    }
    func setLabel() {
        for i in 0...rightLabel.count - 1 {
            rightLabel[i].textColor = labelColor[i]
            rightLabel[i].font = UIFont.systemFont(ofSize: 26)
            leftLabel[i].textColor = labelColor[i]
            leftLabel[i].font = UIFont.systemFont(ofSize: 17)
            leftLabel[i].text = leftLabelText[i]
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
