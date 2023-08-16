//
//  TranslationViewController.swift
//  SeSAC3Week4
//
//  Created by hoon on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslationViewController: UIViewController {

    
    
    @IBOutlet var originalTextView: UITextView!
    @IBOutlet var translateTextView: UITextView!
    @IBOutlet var requestButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //---동일한 코드다.
        originalTextView.text = UserDefaultsHelper.standard.nickname
        originalTextView.text = UserDefaults.standard.string(forKey: "nickname")
        //---
        
        
        UserDefaults.standard.set("고래밥", forKey: "nickname")
        UserDefaultsHelper.standard.nickname = "칙촉"
        
        
        originalTextView.text = ""
        translateTextView.text = ""
        translateTextView.isEditable = false //번역결과창 편집 불가능하도록함
        
    }

    
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        TranslateAPIManger.shared.callRequest(text: originalTextView.text ?? "") { result in
            self.translateTextView.text = result
        }
        
        
        
    }
    
    

}
