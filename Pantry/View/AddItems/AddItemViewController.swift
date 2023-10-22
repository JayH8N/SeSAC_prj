

import UIKit
import YPImagePicker
import Toast
import RealmSwift

class AddItemViewController: BaseViewController {

    var refrigerId: ObjectId?
    
    var notificationOption: NotificationOption = .none //알람 초기설정
    var storageIndex = 0
    
    let viewModel = AddItemViewModel()
    let repository = RefrigeratorRepository()
    
    let mainView = AddItemView()
    
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNav()
        setupKeyboardEvent()
        setBind()
        setUIMenu()
        
        mainView.delegate = self
        mainView.memoTextView.delegate = self
        mainView.nameTextField.delegate = self
    }
    
    private func setBind() {
        viewModel.name.bind { [weak self] name in
            self?.mainView.nameTextField.text = name
            self?.viewModel.isValid.value = !name.isEmpty
        }
        
        viewModel.isValid.bind { [weak self] isValid in
            self?.navigationItem.rightBarButtonItem?.isEnabled = isValid
        }
    }
    
    override func configureView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        mainView.scrollView.addGestureRecognizer(tapGesture)
        
        mainView.nameTextField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        mainView.storageType.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        mainView.datePicker.addTarget(self, action: #selector(datePickerPickedValue), for: .valueChanged)
        mainView.stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        mainView.notiButton.addTarget(self, action: #selector(notiButtonTapped), for: .touchUpInside)
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
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
                    self?.notificationOption = .none
                },
                UIAction(title: String(format: NSLocalizedString("dayAlarm", comment: ""), 1)) { [weak self] _ in
                    self?.mainView.notiButton.configuration?.attributedTitle = configSetTitle(title: String(format: NSLocalizedString("shortDayAlarm", comment: ""), 1))
                    self?.notificationOption = .oneDayBefore
                },
                UIAction(title: String(format: NSLocalizedString("dayAlarm", comment: ""), 3)) { [weak self] _ in
                    self?.mainView.notiButton.configuration?.attributedTitle = configSetTitle(title: String(format: NSLocalizedString("shortDayAlarm", comment: ""), 3))
                    self?.notificationOption = .threeDayBefore
                },
                UIAction(title: String(format: NSLocalizedString("dayAlarm", comment: ""), 7)) { [weak self] _ in
                    self?.mainView.notiButton.configuration?.attributedTitle = configSetTitle(title: String(format: NSLocalizedString("shortDayAlarm", comment: ""), 7))
                    self?.notificationOption = .sevenDayBefore
                }
            ]
        }
        
        mainView.notiButton.menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        mainView.notiButton.showsMenuAsPrimaryAction = true
    }
    
    
}
 
extension AddItemViewController {
    private func initNav() {
        let addFoods = NSLocalizedString("AddItem", comment: "")
        let cancel = NSLocalizedString("Cancel", comment: "")
        let add = NSLocalizedString("Add", comment: "")
        
        self.navigationItem.title = addFoods
        
        let addButton = UIBarButtonItem(title: add, style: .done, target: self, action: #selector(addButtonTapped))
        
        let cancelButton = UIBarButtonItem(title: cancel, style: .done, target: self, action: #selector(cancelButtonTapped))
        
        navigationItem.setRightBarButton(addButton, animated: false)
        navigationItem.setLeftBarButton(cancelButton, animated: false)
        
        addButton.tintColor = .blue
        cancelButton.tintColor = .red
    }
}

//navigationBar Button TouchEvent
extension AddItemViewController {
    //MARK: ADD
    @objc private func addButtonTapped() {
        
        let item = Items(state: mainView.storageType.selectedSegmentIndex,
                         name: mainView.nameTextField.text ?? "",
                         count: Int(mainView.stepper.value),
                         registDay: Date(),
                         expiryDay: mainView.datePicker.date,
                         memo: mainView.memoTextView.text ?? "")
        
        DocumentManager.shared.saveImageToDocument(fileName: "JH\(item._id)", image: mainView.selectedImage ?? UIImage(named: "basicRefiger")!)
        
        repository.addItemToRefrigerator(item, refrigeratorId: refrigerId!)
        
        if storageIndex == 0 {
            LocalNotificationManager.shared.createNotification(item: item, notificationDay: notificationOption)
        }
        
        NotificationCenter.default.post(name: Notification.Name("itemReload"), object: nil)
        
        dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped() {

        dismiss(animated: true)
    }
}

extension AddItemViewController: YPImagePickerProtocol {
    func presentImagePicker(picker: YPImagePicker) {
        present(picker, animated: true)
    }
}

//valueChanged
extension AddItemViewController {
    @objc private func nameChanged() {
        updateCountLimitLabel()
        viewModel.name.value = mainView.nameTextField.text ?? ""
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            mainView.notiButton.isHidden = true
            storageIndex = 1
        } else {
            mainView.notiButton.isHidden = false
            storageIndex = 0
        }
        
        ////인덱스 1이라면 알람 설정 이전에 했더라도 무효화 시켜버림 => if문으로 분기처리
    }
    
    @objc private func datePickerPickedValue() {
        print(mainView.datePicker.date)
    }
    
    @objc private func stepperValueChanged() {
        mainView.qLabel.text = String(Int(mainView.stepper.value))
        print(Int(mainView.stepper.value))
    }
    
    @objc private func notiButtonTapped() {
    
    }
}

extension AddItemViewController: UITextViewDelegate, UITextFieldDelegate {
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
    
    func updateCountLimitLabel() {
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
