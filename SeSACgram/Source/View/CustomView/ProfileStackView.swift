//
//  ProfileStackView.swift
//  SeSACgram
//
//  Created by hoon on 12/17/23.
//

import UIKit
import Then
import SnapKit

final class ProfileStackView: BaseView {
    
    private lazy var stackView = UIStackView(arrangedSubviews: [countLabel, titleLabel]).then {
        $0.axis = .vertical
        $0.spacing = 2
    }
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .light)
        $0.textAlignment = .center
    }
    private let countLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 19, weight: .semibold)
        $0.text = "0"
        $0.textAlignment = .center
    }
    
    init(title: String) {
        super.init(frame: .zero)
        setupUI()
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        self.backgroundColor = .clear
        configureView()
        setConstraints()
    }
    
    override func configureView() {
        addSubview(stackView)
    }
    
    override func setConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
