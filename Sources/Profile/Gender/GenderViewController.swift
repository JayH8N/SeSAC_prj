//
//  GenderViewController.swift
//  Media
//
//  Created by hoon on 2023/08/29.
//

import UIKit


class GenderViewController: BaseViewController {
    
    
    var gender: [String] = ["성별 선택", "남자", "여자"]
    
    let mainView = GenderView()
    
    var completionHandler: ((String)-> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        title = "성별"
        
        mainView.pickerView.delegate = self
        mainView.pickerView.dataSource = self
    }
    
    override func configureView() {
        super.configureView()
        
        mainView.doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func doneButtonClicked() {
        dismiss(animated: true)
    }
    
    
    
    
    override func setConstraints() {
        super.setConstraints()
    }
    

    
}

extension GenderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(gender[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(gender[row]), Notification값전달 1")
        NotificationCenter.default.post(name: Notification.Name("PickerView"), object: nil, userInfo: ["gender": gender[row]])
        //completionHandler?(gender[row])
    }
    

}
