//
//  SearchViewTableViewCell.swift
//  App_Store
//
//  Created by hoon on 11/6/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class SearchViewTableViewCell: BaseTableViewCell {
    
    let screenshotImages = PublishRelay<[String]>()
    
    var disposeBag = DisposeBag()
    
//MARK: - Properties
    let appIconImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    let appNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    let downloadButton = UIButton().then {
        $0.setTitle("받기", for: .normal)
        $0.setTitleColor(UIColor.systemBlue, for: .normal)
        $0.backgroundColor = .systemGray5
        $0.layer.cornerRadius = 15
    }
    
    let downloadLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
        $0.text = "앱 내 구입"
        $0.textAlignment = .center
        $0.textColor = .lightGray
    }
    
    
    lazy var screenshotCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.identifier)
        $0.showsHorizontalScrollIndicator = false
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        screenshotImages
            .bind(to: screenshotCollectionView.rx.items(cellIdentifier: ScreenshotCell.identifier, cellType: ScreenshotCell.self)) { row, element, cell in
                cell.setCell(url: element)
            }
            .disposed(by: disposeBag)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
        bind()
    }
    
    override func configureView() {
        self.selectionStyle = .none
        
        contentView.addSubview(appIconImage)
        contentView.addSubview(appNameLabel)
        contentView.addSubview(downloadButton)
        contentView.addSubview(downloadLabel)
        contentView.addSubview(screenshotCollectionView)
    }
    
    override func setConstraints() {
        appIconImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(appIconImage)
            $0.leading.equalTo(appIconImage.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(appIconImage).multipliedBy(0.8)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
        
        downloadLabel.snp.makeConstraints {
            $0.top.equalTo(downloadButton.snp.bottom).offset(4)
            $0.centerX.equalTo(downloadButton)
        }
        
        screenshotCollectionView.snp.makeConstraints {
            $0.top.equalTo(appIconImage.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(180)
        }
    }
    
    func setTableCell(data: AppInfo) {
        appNameLabel.text = data.trackName
        screenshotImages.accept(data.screenshotUrls)
        
        let url = data.artworkUrl60
        if let url = URL(string: url) {
            appIconImage.kf.setImage(with: url)
            //, options: [.processor(ResizingImageProcessor(referenceSize: CGSize(width: 60, height: 60)))])
        }
    }
    
}

extension SearchViewTableViewCell {
    
    func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let size = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: size / 3.5, height: (size / 4) * 1.7)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
}
