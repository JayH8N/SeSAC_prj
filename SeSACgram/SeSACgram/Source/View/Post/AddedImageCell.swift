//
//  AddedImageCell.swift
//  SeSACgram
//
//  Created by hoon on 12/1/23.
//

import UIKit
import SnapKit
import SnapKit

final class AddedImageCell: BaseCollectionViewCell {
    
    private var indexPath: Int?
    weak var removeDelegate: RemoveImageProtocol?
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = Constants.Size.cellCornerRadius
    }
    
    private let removeButton = UIButton.makeHighlightedButton(withImageName: "xmark.circle.fill", size: 30)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        removeButton.addTarget(self, action: #selector(tappedRemoveButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var description: String {
        String(describing: Self.self)
    }
    
    private func setLayer() {
        layer.cornerRadius = Constants.Size.cellCornerRadius
        layer.borderWidth = 3
        layer.borderColor = Constants.Color.DeepGreen.cgColor
    }
    
    override func configureView() {
        setLayer()
        contentView.addSubview(imageView)
        contentView.addSubview(removeButton)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        removeButton.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).inset(-10)
            $0.trailing.equalTo(self.snp.trailing).inset(-10)
        }
    }
    
    func setImage(image: UIImage, indexPath: Int) {
        imageView.image = image
        self.indexPath = indexPath
    }
    
    @objc private func tappedRemoveButton() {
        if let indexPath {
            removeDelegate?.removeImage(indexPath: indexPath)
        }
    }
    
}
