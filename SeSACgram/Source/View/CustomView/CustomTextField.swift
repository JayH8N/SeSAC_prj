//
//  CustomTextField.swift
//  SeSACgram
//
//  Created by hoon on 11/18/23.
//

import UIKit
import SnapKit
import Then

final class CustomTextField: UITextField {
    
    enum Style {
        case id, pw, birth
    }
    
    let isValid: Bool = true
    
    //달력
    private let datePicker = UIPickerView()
    private var years = Array(1994...2100).map { String($0) }
    private let months = Array(1...12).map { String($0) }
    private let days = Array(1...31).map { String($0) }
    
    
    let rightButton = UIButton().then {
        $0.tintColor = Constants.Color.DeepGreen
        $0.isHidden = true
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
    }
    
    init(placeholder: String, style: Style) {
        super.init(frame: .zero)
        self.delegate = self
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.tintColor = Constants.Color.DeepGreen
        self.layer.cornerRadius = Constants.Size.textFieldCornerRadius
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 0.0))
        self.leftViewMode = .always
        setRightButtonView(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setRightButtonView(style: Style) {
        rightView = rightButton
        rightViewMode = .always
        switch style {
        case .id:
            rightButton.setImage(Constants.Image.Xmark, for: .normal)
            rightButton.addTarget(self, action: #selector(xmarkTapped), for: .touchUpInside)
        case .pw:
            rightButton.setImage(Constants.Image.CloseEye, for: .normal)
            rightButton.addTarget(self, action: #selector(eyeTapped), for: .touchUpInside)
            isSecureTextEntry = true
        case .birth:
            self.tintColor = .clear
            datePicker.delegate = self
            datePicker.dataSource = self
            self.inputView = datePicker
        }
    }
}

//MARK: - extension
extension CustomTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderColor = Constants.Color.DeepGreen.cgColor
        rightButton.isHidden = false
    }
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderColor = UIColor.lightGray.cgColor
        rightButton.isHidden = true
    }
}

extension CustomTextField {
    @objc private func xmarkTapped() {
        self.text = ""
    }
    @objc private func eyeTapped() {
        isSecureTextEntry.toggle()
        if isSecureTextEntry {
            rightButton.setImage(Constants.Image.CloseEye, for: .normal)
        } else {
            rightButton.setImage(Constants.Image.OpenEye, for: .normal)
        }
    }
}

//UIPickerView
extension CustomTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return years.count
        case 1: return months.count
        case 2: return days.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return years[row]
        case 1: return months[row]
        case 2: return days[row]
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedYear = years[pickerView.selectedRow(inComponent: 0)]
        let selectedMonth = months[pickerView.selectedRow(inComponent: 1)]
        let selectedDay = days[pickerView.selectedRow(inComponent: 2)]
        
        self.text = "\(selectedYear)년 \(selectedMonth)월 \(selectedDay)일"
    }
    
    
}
