//
//  EditItemView.swift
//  Pantry
//
//  Created by hoon on 2023/10/21.
//

import UIKit
import Then
import SnapKit
import YPImagePicker

class EditItemView: BaseView {
    
    weak var delegate: YPImagePickerProtocol?
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
    }
    
    let nameLimit = 15
    let memoLimit = 150
    
//MARK: - Properties
    let uiView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.isUserInteractionEnabled = true
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
    
    let nameTextField = UITextField().then {
        $0.placeholder = NSLocalizedString("ItemName", comment: "")
        $0.backgroundColor = .white
        $0.tintColor = .black
        $0.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("ItemName", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
    
    lazy var nameLimitLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .left
    }
    
    let items = [NSLocalizedString("Refrigerator", comment: ""), NSLocalizedString("Freezer", comment: "")]
    
    let storageBackView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.masksToBounds = true
    }
    
    lazy var storageType = UISegmentedControl(items: items).then {
        $0.selectedSegmentIndex = 0
        $0.backgroundColor = .white
        $0.selectedSegmentTintColor = UIColor.refrigerCellBackground
    }
    
    //EXP Date,
    let expBackUIView = UIView().then {
        $0.backgroundColor = .white
    }
    let expLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .compact
        $0.tintColor = UIColor.brown.withAlphaComponent(0.7)
    }
    
    //amount
    let amountBackUIView = UIView().then {
        $0.backgroundColor = .white
    }
    let amountLabel = UILabel().then {
        $0.textAlignment = .center
    }
    let stepper = UIStepper().then {
        $0.minimumValue = 1
        $0.maximumValue = 100
    }
    let qLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 28)
        $0.textAlignment = .center
        $0.text = String(1)
    }
    
    lazy var amountStackView = UIStackView(arrangedSubviews: [stepper, qLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 3
    }
    
    //memo
    let memoBackUIView = UIView().then {
        $0.backgroundColor = .white
    }
    let memoLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 17)
    }
    let memoTextView = UITextView().then {
        $0.tintColor = .black
        $0.font = .systemFont(ofSize: 17)
    }
    
    lazy var memoLimitLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .left
    }
    
    let deleteButton = UIButton(type: .system).then {
        $0.setTitle(NSLocalizedString("Delete", comment: ""), for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        $0.setImage(UIImage(systemName: "trash"), for: .normal)
        $0.tintColor = .white
        $0.setBackgroundColor(UIColor.red, for: .normal)
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
    }
    
    let notiButton = UIButton.uiButtonConfigure(imageName: "bell", title: "None")
    
    override func layoutSubviews() {
        
        storageBackView.roundCorners(cornerRadius: 8, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        nameTextField.layer.cornerRadius = 8
        memoBackUIView.layer.cornerRadius = 8
        amountBackUIView.roundCorners(cornerRadius: 8, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
        memoTextView.layer.addBorder([.top], width: 0.3, color: UIColor.gray.cgColor)
        
        amountBackUIView.layer.addBorder([.top], width: 0.3, color: UIColor.lightGray.cgColor)
        notiButton.layer.cornerRadius = notiButton.bounds.width / 2
    }
    
    
    override func configureView() {
        addSubview(blurEffect)
        addSubview(scrollView)
        
        scrollView.addSubview(uiView)
        uiView.addSubview(imageView)
        uiView.addSubview(editLabel)
        scrollView.addSubview(notiButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        uiView.addGestureRecognizer(tapGesture)
        
        ///
        scrollView.addSubview(storageBackView)
        storageBackView.addSubview(storageType)
        
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(nameLimitLabel)
        scrollView.addSubview(expBackUIView)
        
        //EXP Date
        scrollView.addSubview(expBackUIView)
        expBackUIView.addSubview(expLabel)
        expBackUIView.addSubview(datePicker)
        setExtraConfig()
        
        //amount
        scrollView.addSubview(amountBackUIView)
        amountBackUIView.addSubview(amountLabel)
        amountBackUIView.addSubview(amountStackView)
        
        //memo
        scrollView.addSubview(memoBackUIView)
        memoBackUIView.addSubview(memoLabel)
        memoBackUIView.addSubview(memoTextView)
        scrollView.addSubview(memoLimitLabel)
        
        scrollView.addSubview(deleteButton)
    }
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        uiView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(self.snp.width).multipliedBy(0.4)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(25)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        editLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(uiView.snp.height).multipliedBy(0.23)
        }
        
        nameTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        nameTextField.leftViewMode = .always
        nameTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(uiView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
        
        nameLimitLabel.snp.makeConstraints {
            $0.trailing.equalTo(nameTextField.snp.trailing)
            $0.top.equalTo(nameTextField.snp.bottom).offset(3)
        }
        
        storageBackView.snp.makeConstraints {
            $0.height.equalTo(nameTextField.snp.height)
            $0.top.equalTo(nameLimitLabel.snp.bottom).offset(19)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(nameTextField.snp.width)
        }
        
        storageType.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        expBackUIView.snp.makeConstraints {
            $0.height.equalTo(nameTextField.snp.height)
            $0.top.equalTo(storageType.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(nameTextField.snp.width)
        }
        
        expLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(expBackUIView.snp.leading).inset(10)
        }
        
        datePicker.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(expBackUIView.snp.trailing).inset(10)
        }
        
        amountBackUIView.snp.makeConstraints {
            $0.height.equalTo(nameTextField.snp.height)
            $0.top.equalTo(expBackUIView.snp.bottom)//.offset(2)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(nameTextField.snp.width)
        }
        
        amountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(amountBackUIView.snp.leading).inset(10)
        }
        
        //stepper, plabel 스택뷰로 묶어서 넣기
        amountStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(amountBackUIView.snp.trailing).inset(10)
        }
        qLabel.snp.makeConstraints {
            $0.width.equalTo(amountStackView.snp.height).multipliedBy(1.5)
        }
        
        memoBackUIView.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.top.equalTo(amountBackUIView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(nameTextField.snp.width)
        }
        
        memoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(13)
        }
        memoTextView.snp.makeConstraints {
            $0.top.equalTo(memoLabel.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        
        memoLimitLabel.snp.makeConstraints {
            $0.trailing.equalTo(memoBackUIView.snp.trailing)
            $0.top.equalTo(memoBackUIView.snp.bottom).offset(3)
        }
        
        deleteButton.snp.makeConstraints {
            $0.height.equalTo(nameTextField)
            $0.top.equalTo(memoBackUIView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(nameTextField)
        }
        
        notiButton.snp.makeConstraints {
            $0.bottom.equalTo(uiView.snp.bottom)
            $0.size.equalTo(uiView.snp.width).multipliedBy(0.37)
            $0.leading.equalTo(uiView.snp.trailing).offset(13)
        }
        
        
    }
    
    private func setExtraConfig() {
        //DatePicker Locale설정
        if let preferLocale = Locale.preferredLanguages.first {
            datePicker.locale = Locale(identifier: preferLocale)
        }
        expLabel.text = NSLocalizedString("Expiry date", comment: "")
        amountLabel.text = NSLocalizedString("Quantity", comment: "")
        memoLabel.text = NSLocalizedString("Memo", comment: "")
    }
    
    
}

extension EditItemView {
    
    @objc func imageViewTapped() {

        var config = YPImagePickerConfiguration()
        config.library.onlySquare = true
        config.startOnScreen = .photo
        let picker = YPImagePicker(configuration: config)
        
        // 이미지 선택이 완료
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                self.imageView.image = photo.image
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        // YPImagePicker를 표시
        delegate?.presentImagePicker(picker: picker)
    }
    
}
