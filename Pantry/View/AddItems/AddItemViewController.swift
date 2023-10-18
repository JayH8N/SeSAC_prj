

import UIKit
import YPImagePicker
import Toast

class AddItemViewController: BaseViewController {
    
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
        
        mainView.delegate = self
        
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
    
    @objc private func addButtonTapped() {
        
        print(mainView.nameTextField.text,
              mainView.storageType.selectedSegmentIndex,
              mainView.datePicker.date,
              mainView.stepper.value,
              mainView.memoTextView.text)
        
        
        
        
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
        viewModel.name.value = mainView.nameTextField.text ?? ""
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
    
    @objc private func datePickerPickedValue() {
        print(mainView.datePicker.date)
    }
    
    @objc private func stepperValueChanged() {
        mainView.qLabel.text = String(Int(mainView.stepper.value))
        print(Int(mainView.stepper.value))
    }
    

}
