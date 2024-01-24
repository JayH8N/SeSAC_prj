//
//  NameChangeViewController.swift
//  Tamagotchi
//
//  Created by hoon on 2023/08/05.
//

import UIKit

class NameChangeViewController: UIViewController {

    @IBOutlet var changeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(myName)님 이름 정하기"
        self.setBackgroundColor()
        savingButton()
        setChangeField()
    }
    
    func setChangeField() {
        changeField.backgroundColor = .clear
        changeField.borderStyle = .none
        changeField.layer.addBorder([.bottom], width: 1)
        changeField.placeholder = "\(myName)님 이름을 알려주세요!"
    }
    
    func savingButton() {
        let saveButton = "저장"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: saveButton, style: .plain, target: self, action: #selector(savingButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = fontColor
    }
    
    enum NameError: Error {
        case isNotRange
    }
    
    func nameChangeError(text: String) throws -> () {
        if text.count >= 2 && text.count <= 6 {
            //myName = text
            NotificationCenter.default.post(name: NSNotification.Name("StoreNewName"), object: nil, userInfo: ["NewValue": text])
            navigationController?.popViewController(animated: true)
        } else {
            throw NameError.isNotRange
        }
    }
    
    
    @objc
    func savingButtonClicked(_ sender: UIBarButtonItem) {
        do {
            try nameChangeError(text: changeField.text!)
        } catch {
            alertOnly1Button(title: "2글자 이상 6글자 이하로\n입력해주세요!")
        }
    }

}

extension NameChangeViewController: ReusableIdentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
