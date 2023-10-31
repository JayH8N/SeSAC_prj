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
    var notiPermission: Bool?
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
        checkNotificationPermission()
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
            mainView.notiIntroDuctionButton.isHidden = true
        } else {
            mainView.notiButton.isHidden = false
            mainView.notiIntroDuctionButton.isHidden = false
        }
    }
    
    private func initialAlarmSetting() {
        func configSetTitle(title: String) -> AttributedString {
            var attString = AttributedString(title)
            attString.font = .systemFont(ofSize: 11, weight: .light)
            return attString
        }
        
        guard let data = data else { return }
        
        let alarmInfo = LocalNotificationManager.shared.readAlarmInfo(identifier: "\(data._id)")
        let notiTitle: String
        switch alarmInfo {
        case .none:
            notiTitle = NSLocalizedString("None", comment: "")
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
        mainView.notiIntroDuctionButton.addTarget(self, action: #selector(notiIntroTapped), for: .touchUpInside)
        mainView.notiPermissionButton.addTarget(self, action: #selector(notiPermissionButtonTapped), for: .touchUpInside)
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
    
    private func checkNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized, .provisional: // 알람 권한이 이미 허용된 경우 또는 임시로 허용된 경우
                DispatchQueue.main.async {
                    self.notiPermission = true
                    self.mainView.notiButton.isHidden = false
                    self.mainView.notiIntroDuctionButton.isHidden = false
                    self.mainView.notiPermissionButton.isHidden = true
                }
            case .denied: // 알람 권한이 거부된 경우
                DispatchQueue.main.async {
                    self.notiPermission = false
                    self.mainView.notiButton.isHidden = true
                    self.mainView.notiIntroDuctionButton.isHidden = true
                    self.mainView.notiPermissionButton.isHidden = false
                }
            default:
                break
            }
        }
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
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "TAEBAEK milkyway", size: 20)!]
        updateButton.tintColor = UIColor.rightButton
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
        NotificationCenter.default.post(name: Notification.Name("RefrigerReloadData"), object: nil)
        dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        
        dismiss(animated: true)
    }
    
    @objc private func deleteButtonTapped() {
        HapticFeedbackManager.shared.provideFeedback()
        let title = NSLocalizedString("RemoveData", comment: "")
        let message = NSLocalizedString("RemoveDataMessage", comment: "")
        
        showAlertView(title: title, message: message) { _ in
            guard let data = self.data else { return }
            
            LocalNotificationManager.shared.removeNotification(item: data)
            self.repository.removeItemFromRefrigerator(data._id)
            
            NotificationCenter.default.post(name: Notification.Name("itemReload"), object: nil)
            NotificationCenter.default.post(name: Notification.Name("RefrigerReloadData"), object: nil)
            
            self.dismiss(animated: true)
        }
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
            mainView.notiPermissionButton.isHidden = true
            mainView.notiButton.isHidden = true
            mainView.notiIntroDuctionButton.isHidden = true
            storageIndex = 1
        } else {
            if notiPermission == false { //index == 0, 알림권한 거부
                mainView.notiPermissionButton.isHidden = false
                mainView.notiButton.isHidden = true
                mainView.notiIntroDuctionButton.isHidden = true
            } else { //index == 0, 알림권한 허용
                mainView.notiPermissionButton.isHidden = true
                mainView.notiButton.isHidden = false
                mainView.notiIntroDuctionButton.isHidden = false
            }
            storageIndex = 0
        }
    }
    
    @objc private func datePickerPickedValue() {
        let currentDate = mainView.datePicker.date
        print(currentDate)
    }
    
    @objc private func stepperValueChanged() {
        mainView.qLabel.text = String(Int(mainView.stepper.value))
        print(Int(mainView.stepper.value))
    }
    
    @objc private func notiIntroTapped() {
        self.view.makeToast(NSLocalizedString("AlarmIntro", comment: ""), duration: 2.0, position: .center)
    }
    
    @objc private func notiPermissionButtonTapped() {
        let alarmPermissionTitle = NSLocalizedString("AlarmPermissionTitle", comment: "")
        let alarmPermissionMessage = NSLocalizedString("AlarmPermissionMessage", comment: "")
        
        
        showAlertView(title: alarmPermissionTitle, message: alarmPermissionMessage) { [weak self] _ in
            self?.dismiss(animated: true)
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
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
