//
//  EditItemViewController.swift
//  Pantry
//
//  Created by hoon on 2023/10/21.
//

import UIKit
import YPImagePicker
import Toast
import RealmSwift

class EditItemViewController: BaseViewController {
    
    var data: Items?
    var notiOption: NotificationOption = .none
    var storageIndex = 0
    let repository = RefrigeratorRepository()
    
    let mainView = EditItemView()
    
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNav()
        setUIMenu()
        setupKeyboardEvent()
        initialSetting()
        initialAlarmSetting()
        mainView.delegate = self
        mainView.memoTextView.delegate = self
        mainView.nameTextField.delegate = self
        updateCountLimitLabel()
    }
    
    private func initialSetting() {
        guard let data = data else { return }
        
        mainView.imageView.image = DocumentManager.shared.loadImageFromDocument(fileName: "JH\(data._id)")
        
        mainView.nameTextField.text = data.name
        mainView.storageType.selectedSegmentIndex = data.state
        mainView.datePicker.date = data.expiryDay
        mainView.stepper.value = Double(data.count)
        mainView.qLabel.text = String(data.count)
        mainView.memoTextView.text = data.memo
        
        if mainView.storageType.selectedSegmentIndex == 1 {
            mainView.notiButton.isHidden = true
        } else {
            mainView.notiButton.isHidden = false
        }
    }
    
    private func initialAlarmSetting() {
        func configSetTitle(title: String) -> AttributedString {
            var attString = AttributedString(title)
            attString.font = .systemFont(ofSize: 11, weight: .light)
            return attString
        }
        
        let none = NSLocalizedString("None", comment: "")
        
        guard let data = data else { return }
        
        let alarmInfo = LocalNotificationManager.shared.readAlarmInfo(identifier: "\(data._id)")
        let notiTitle: String
        switch alarmInfo {
        case .none:
            notiTitle = none
            self.notiOption = .none
        case .oneDayBefore:
            notiTitle = String(format: NSLocalizedString("shortDayAlarm", comment: ""), 1)
            self.notiOption = .oneDayBefore
        case .threeDayBefore:
            notiTitle = String(format: NSLocalizedString("shortDayAlarm", comment: ""), 3)
            self.notiOption = .threeDayBefore
        case .sevenDayBefore:
            notiTitle = String(format: NSLocalizedString("shortDayAlarm", comment: ""), 7)
            self.notiOption = .sevenDayBefore
        }
        self.mainView.notiButton.configuration?.attributedTitle = configSetTitle(title: notiTitle)
    }
    
    override func configureView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        mainView.scrollView.addGestureRecognizer(tapGesture)
        
        mainView.nameTextField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        mainView.storageType.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        mainView.datePicker.addTarget(self, action: #selector(datePickerPickedValue), for: .valueChanged)
        mainView.stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        mainView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
    
    private func setUIMenu() {
        func configSetTitle(title: String) -> AttributedString {
            var attString = AttributedString(title)
            attString.font = .systemFont(ofSize: 11, weight: .light)
            return attString
        }
        
        let none = NSLocalizedString("None", comment: "")
        
        var menuItems: [UIAction] {
            return [
                UIAction(title: none) { [weak self] _ in
                    self?.mainView.notiButton.configuration?.attributedTitle = configSetTitle(title: none)
                    self?.notiOption = .none
                },
                UIAction(title: String(format: NSLocalizedString("dayAlarm", comment: ""), 1)) { [weak self] _ in
                    self?.mainView.notiButton.configuration?.attributedTitle = configSetTitle(title: String(format: NSLocalizedString("shortDayAlarm", comment: ""), 1))
                    self?.notiOption = .oneDayBefore
                },
                UIAction(title: String(format: NSLocalizedString("dayAlarm", comment: ""), 3)) { [weak self] _ in
                    self?.mainView.notiButton.configuration?.attributedTitle = configSetTitle(title: String(format: NSLocalizedString("shortDayAlarm", comment: ""), 3))
                    self?.notiOption = .threeDayBefore
                },
                UIAction(title: String(format: NSLocalizedString("dayAlarm", comment: ""), 7)) { [weak self] _ in
                    self?.mainView.notiButton.configuration?.attributedTitle = configSetTitle(title: String(format: NSLocalizedString("shortDayAlarm", comment: ""), 7))
                    self?.notiOption = .sevenDayBefore
                }
            ]
        }
        
        mainView.notiButton.menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        mainView.notiButton.showsMenuAsPrimaryAction = true
    }
    
    
    //keyboard 나타날시 view y축 위치 조정 notification
    private func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentResponder as? UITextView else { return }
        
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        
        let convertedTextFieldFrame = view.convert(currentTextField.frame,
                                                   from: currentTextField.superview)
        
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        
        if textFieldBottomY > keyboardTopY {
            let textFieldTopY = convertedTextFieldFrame.origin.y
            
            let newFrame = textFieldTopY - keyboardTopY/1.6
            view.frame.origin.y -= newFrame
        }
        
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    
}

extension EditItemViewController {
    private func initNav() {
        let edit = NSLocalizedString("Edit", comment: "")
        let cancel = NSLocalizedString("Cancel", comment: "")
        let update = NSLocalizedString("Update", comment: "")
        
        self.navigationItem.title = edit
        
        let updateButton = UIBarButtonItem(title: update, style: .done, target: self, action: #selector(updateButtonTapped))
        
        let cancelButton = UIBarButtonItem(title: cancel, style: .done, target: self, action: #selector(cancelButtonTapped))
        
        navigationItem.setRightBarButton(updateButton, animated: false)
        navigationItem.setLeftBarButton(cancelButton, animated: false)
        
        updateButton.tintColor = .blue
        cancelButton.tintColor = .red
    }
}

//navigationBar Button TouchEvent
extension EditItemViewController {
    
    //업데이트 버튼
    @objc private func updateButtonTapped() {
        
        guard let data = data else { return }
        
        repository.updateItemFromRefrigerator(data._id,
                                              state: mainView.storageType.selectedSegmentIndex,
                                              name: mainView.nameTextField.text ?? "",
                                              count: Int(mainView.stepper.value),
                                              expiryDay: mainView.datePicker.date,
                                              memo: mainView.memoTextView.text ?? "")
        
        DocumentManager.shared.saveImageToDocument(fileName: "JH\(data._id)", image: mainView.imageView.image!)
        
        if mainView.storageType.selectedSegmentIndex == 0 {
            LocalNotificationManager.shared.createNotification(item: data, notificationDay: notiOption)
        } else if mainView.storageType.selectedSegmentIndex == 1 {
            LocalNotificationManager.shared.removeNotification(item: data)
        }
        
        NotificationCenter.default.post(name: Notification.Name("itemReload"), object: nil)
        
        dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        
        dismiss(animated: true)
    }
    
    @objc private func deleteButtonTapped() {
        HapticFeedbackManager.shared.provideFeedback()
        
        guard let data = data else { return }
        
        LocalNotificationManager.shared.removeNotification(item: data)
        repository.removeItemFromRefrigerator(data._id)
        
        NotificationCenter.default.post(name: Notification.Name("itemReload"), object: nil)
        
        dismiss(animated: true)
    }
}

extension EditItemViewController: YPImagePickerProtocol {
    func presentImagePicker(picker: YPImagePicker) {
        present(picker, animated: true)
    }
}

//valueChanged
extension EditItemViewController {
    @objc private func nameChanged() {
        updateCountLimitLabel()
        if let text = mainView.nameTextField.text, !text.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            mainView.notiButton.isHidden = true
            storageIndex = 1
        } else {
            mainView.notiButton.isHidden = false
            storageIndex = 0
        }
    }
    
    @objc private func datePickerPickedValue() {
        print(mainView.datePicker.date)
    }
    
    @objc private func stepperValueChanged() {
        mainView.qLabel.text = String(Int(mainView.stepper.value))
        print(Int(mainView.stepper.value))
    }
}

extension EditItemViewController: UITextViewDelegate, UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nowString = mainView.nameTextField.text ?? ""
        let newString = (nowString as NSString).replacingCharacters(in: range, with: string)
        
        if newString.count <= mainView.nameLimit {
            return true
        } else {
            return false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let nowString = mainView.memoTextView.text ?? ""
        let newString = (nowString as NSString).replacingCharacters(in: range, with: text)
        
        if newString.count <= mainView.memoLimit {
            return true
        } else {
            return false
        }
    }
    
    private func updateCountLimitLabel() {
        if let text = mainView.nameTextField.text {
            mainView.nameLimitLabel.text = "(\(text.count)/\(mainView.nameLimit))"
        }
        if let memo = mainView.memoTextView.text {
            mainView.memoLimitLabel.text = "(\(memo.count)/\(mainView.memoLimit))"
        }
    }
    
    //textview 내용 변경 호출 메서드
    func textViewDidChange(_ textView: UITextView) {
        updateCountLimitLabel()
    }
}
