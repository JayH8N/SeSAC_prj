

import UIKit
import Then
import SnapKit
import YPImagePicker

class AddFoodsView: BaseView {
    
    var selectedImage: UIImage?
    
    weak var delegate: YPImagePickerProtocol?
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let header = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)).then {
        $0.backgroundColor = .clear
    }
    
    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .clear
        $0.register(FoodsNameCell.self, forCellReuseIdentifier: FoodsNameCell.identifier)
        $0.register(FoodsMemoCell.self, forCellReuseIdentifier: FoodsMemoCell.identifier)
        $0.register(FoodsExDateCell.self, forCellReuseIdentifier: FoodsExDateCell.identifier)
        $0.register(FoodsStateCell.self, forCellReuseIdentifier: FoodsStateCell.identifier)
        $0.register(FoodsQuantityCell.self, forCellReuseIdentifier: FoodsQuantityCell.identifier)
        $0.tableHeaderView = header
    }
    
    let uiView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "basicFood")
        $0.contentMode = .scaleAspectFill
    }
    
    let editLabel = UILabel().then {
        $0.text = NSLocalizedString("Edit", comment: "")
        $0.textColor = .white
        $0.backgroundColor = .darkGray.withAlphaComponent(0.6)
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16)
    }
    
    
    
    override func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubview(blurEffect)
        addSubview(tableView)
        addSubview(uiView)
        uiView.addSubview(imageView)
        uiView.addSubview(editLabel)
        uiView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        uiView.addGestureRecognizer(tapGesture)
    }
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        uiView.snp.makeConstraints {
            $0.center.equalTo(header)
            $0.size.equalTo(self.snp.width).multipliedBy(0.4)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        editLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(uiView.snp.height).multipliedBy(0.23)
        }
        
    }
    
    
}

extension AddFoodsView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 1
            case 1:
                return 3
            case 2:
                return 1
            default:
                return 0
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let name = tableView.dequeueReusableCell(withIdentifier: FoodsNameCell.identifier, for: indexPath) as! FoodsNameCell
            return name
        case 1:
            switch indexPath.row {
            case 0:
                let state = tableView.dequeueReusableCell(withIdentifier: FoodsStateCell.identifier, for: indexPath) as! FoodsStateCell
                return state
            case 1:
                let exDate = tableView.dequeueReusableCell(withIdentifier: FoodsExDateCell.identifier, for: indexPath) as! FoodsExDateCell
                return exDate
            case 2:
                let quantity = tableView.dequeueReusableCell(withIdentifier: FoodsQuantityCell.identifier, for: indexPath) as! FoodsQuantityCell
                return quantity
            default:
                return UITableViewCell()
            }
        case 2:
            let memo = tableView.dequeueReusableCell(withIdentifier: FoodsMemoCell.identifier, for: indexPath) as! FoodsMemoCell
            
            return memo
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 150
        } else {
            return 44
        }
    }
    
}


extension AddFoodsView {
    
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
        delegate?.presentImagePicker(picker: picker)
    }
    
}
