//
//  AddViewController.swift
//  Pantry
//
//  Created by hoon on 2023/10/03.
//

import UIKit
import SnapKit
import Then
import YPImagePicker

class AddViewController: BaseViewController {
    
    
    var selectedImage: UIImage?
    
    let nameLimit = 15
    let memoLimit = 50
    
    let viewModel = AddViewModel()
    let repository = RefrigeratorRepository()
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let uiView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    
    
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "basicRefiger")
        $0.contentMode = .scaleAspectFill
    }
    
    let editLabel = UILabel().then {
        $0.text = NSLocalizedString("Edit", comment: "")
        $0.textColor = .white
        $0.backgroundColor = .darkGray.withAlphaComponent(0.6)
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16)
    }
    
    let name = UITextField().then {
        $0.placeholder = NSLocalizedString("EnterTitle", comment: "")
        $0.attributedPlaceholder = NSAttributedString(string: $0.placeholder ?? "",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        $0.tintColor = .black
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
    }
    
    lazy var nameLimitLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .left
        //$0.text = "(0/\(nameLimit))"
    }
    
    let memo = UITextField().then {
        $0.placeholder = NSLocalizedString("Memo", comment: "")
        $0.tintColor = .black
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
    }
    
    lazy var memoLimitLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .left
        //$0.text = "(0/\(memoLimit))"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNav()
        setBind()
        
        name.delegate = self
        memo.delegate = self
        self.hideKeyboardWhenTappedAround()
        updateCountLimitLabel()
    }
    
    private func setBind() {
        viewModel.name.bind { [weak self] name in
            self?.name.text = name
            self?.viewModel.isValid.value = !name.isEmpty
        }
        
        viewModel.isValid.bind { [weak self] isValid in
            self?.navigationItem.rightBarButtonItem?.isEnabled = isValid
        }
    }
    
    
    override func configureView() {
        view.addSubview(blurEffect)
        view.addSubview(uiView)
        uiView.addSubview(imageView)
        uiView.addSubview(editLabel)
        uiView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        uiView.addGestureRecognizer(tapGesture)
        
        view.addSubview(name)
        view.addSubview(nameLimitLabel)
        view.addSubview(memo)
        view.addSubview(memoLimitLabel)
        
        name.addTarget(self, action: #selector(nameTextChanged), for: .editingChanged)
        memo.addTarget(self, action: #selector(memoTextChanged), for: .editingChanged)
    }
    
    @objc func nameTextChanged() {
        updateCountLimitLabel()
        viewModel.name.value = name.text ?? ""
    }
    
    @objc func memoTextChanged() {
        updateCountLimitLabel()
        viewModel.memo.value = memo.text ?? ""
    }
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        uiView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.4)
            $0.size.equalTo(view.snp.width).multipliedBy(0.4)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        editLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(uiView.snp.height).multipliedBy(0.23)
        }
        
        
        name.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        name.leftViewMode = .always
        name.snp.makeConstraints {
            $0.width.equalTo(view.snp.width).multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(uiView.snp.bottom).offset(30)
            $0.height.equalTo(40)
        }
        
        nameLimitLabel.snp.makeConstraints {
            $0.trailing.equalTo(name.snp.trailing)
            $0.top.equalTo(name.snp.bottom).offset(3)
        }
        
        memo.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        memo.leftViewMode = .always
        memo.snp.makeConstraints {
            $0.width.equalTo(name)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameLimitLabel.snp.bottom).offset(19)
            $0.height.equalTo(name)
        }
        
        memoLimitLabel.snp.makeConstraints {
            $0.trailing.equalTo(memo.snp.trailing)
            $0.top.equalTo(memo.snp.bottom).offset(3)
        }
    }
    
    
}

extension AddViewController {
    private func initNav() {
        let addRefriger = NSLocalizedString("AddRefriger", comment: "")
        let cancel = NSLocalizedString("Cancel", comment: "")
        let add = NSLocalizedString("Add", comment: "")
        
        self.navigationItem.title = addRefriger
        self.navigationItem.rightBarButtonItem = .init(title: add, style: .done, target: self, action: #selector(addButtonTapped))
        self.navigationItem.leftBarButtonItem = .init(title: cancel, style: .done, target: self, action: #selector(cancelButtonTapped))
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.blue
        navigationItem.leftBarButtonItem?.tintColor = UIColor.red
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func addButtonTapped() {
        let data = Refrigerator(name: name.text ?? "", memo: memo.text ?? "")

        DocumentManager.shared.saveImageToDocument(fileName: "JH\(data._id)", image: (selectedImage ?? UIImage(named: "basicRefiger"))!)

        repository.createItem(data)

        NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: nil)
        
        dismiss(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func imageViewTapped() {

        var config = YPImagePickerConfiguration()
        config.library.onlySquare = true
        config.startOnScreen = .photo
        let picker = YPImagePicker(configuration: config)
        
        // 이미지 선택이 완료
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                self.imageView.image = photo.image
                self.selectedImage = photo.image
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        // YPImagePicker를 표시
        present(picker, animated: true, completion: nil)
    }
    
}

extension AddViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == name {
            let nowString = name.text ?? ""
            let newString = (nowString as NSString).replacingCharacters(in: range, with: string)
            
            if newString.count <= nameLimit {
                return true
            } else {
                return false
            }
        } else if textField == memo {
            let nowString = memo.text ?? ""
            let newString = (nowString as NSString).replacingCharacters(in: range, with: string)
            
            if newString.count <= memoLimit {
                return true
            } else {
                return false
            }
        }
        
        return true
    }
    
    
    private func updateCountLimitLabel() {
        if let text = name.text {
            nameLimitLabel.text = "(\(text.count)/\(nameLimit))"
        }
        if let memo = memo.text {
            memoLimitLabel.text = "(\(memo.count)/\(memoLimit))"
        }
    }
}
