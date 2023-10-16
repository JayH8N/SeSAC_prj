

import UIKit
import YPImagePicker

class AddFoodsViewController: BaseViewController {
    
    let mainView = AddFoodsView()
    
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        
        setupKeyboardEvent()
        
        mainView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        mainView.tableView.addGestureRecognizer(tapGesture)
    }
    
    
    override func configureView() {
    
    }
    
    override func setConstraints() {
        
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
    
    
    
    
    
    //테이블뷰 터치시 키보드 내려가게 하기
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}


extension AddFoodsViewController {
    private func initNav() {
        let addFoods = NSLocalizedString("AddFoods", comment: "")
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
extension AddFoodsViewController {
    
    @objc private func addButtonTapped() {
        
        
        dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        
        
        dismiss(animated: true)
    }
}

extension AddFoodsViewController: YPImagePickerProtocol {
    func presentImagePicker(picker: YPImagePicker) {
        present(picker, animated: true)
    }
}
