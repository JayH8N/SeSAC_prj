//
//  MainView.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit
import Then
import SnapKit
import RealmSwift
import FSPagerView

class MainView: BaseView {

    let repository = RefrigeratorRepository()
    
    var stored: Results<Refrigerator>!
    var rfID: ObjectId?
    
    let hapticFeedBack = UISelectionFeedbackGenerator()
    
    weak var delegate: NavPushProtocol?
    
//MARK: - Properties
        
    let addButton = UIButton.makeHighlightedButton(withImageName: "plus", size: 30)
    
    let alarmButton = UIButton.makeHighlightedButton(withImageName: "bell", size: 30)
    
    lazy var refrigerCollection = FSPagerView(frame: .zero).then {
        $0.register(RefrigerCell.self, forCellWithReuseIdentifier: RefrigerCell.identifier)
        $0.backgroundColor = .clear
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 10
        $0.layer.shadowOpacity = 0.5
        let size = UIScreen.main.bounds.width
        $0.itemSize = CGSize(width: size * 0.6, height: size * 0.5)
        $0.interitemSpacing = 20
        $0.transformer = FSPagerViewTransformer(type: .overlap)
    }
    
    //EmptyView
    let emptyView = UIView().then {
        $0.backgroundColor = .clear
    }
    let emptyTitleLabel = UILabel().then {
        $0.backgroundColor = .clear
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.text = NSLocalizedString("EmptyViewTitle", comment: "")
        $0.textAlignment = .center
    }
    let emptySubTitleLabel = UILabel().then {
        $0.backgroundColor = .clear
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.text = NSLocalizedString("EmptyViewSubTitle", comment: "")
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    lazy var emptyTextStackView = UIStackView(arrangedSubviews: [emptyTitleLabel, emptySubTitleLabel]).then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
    

//MARK: - Setting
    override func configureView() {
        super.configureView()
        refrigerCollection.dataSource = self
        refrigerCollection.delegate = self
        
        addSubview(refrigerCollection)
        
        refrigerCollection.addSubview(emptyView)
        emptyView.addSubview(emptyTextStackView)
    }
    
    
    override func setConstraints() {
        addButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        alarmButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        refrigerCollection.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(self.snp.height).multipliedBy(0.3)
        }
        
        emptyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emptySubTitleLabel.snp.makeConstraints {
            $0.width.equalTo(emptyTextStackView.snp.width).multipliedBy(0.7)
        }
        
        emptyTextStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
    }
}

extension MainView: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        let count = stored.count
        if count != 0 {
            emptyView.isHidden = true
        } else {
            emptyView.isHidden = false
        }
        return stored.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: RefrigerCell.identifier, at: index) as! RefrigerCell
        
        cell.switchDelegate = self

        let data = stored[index]

        cell.setData(data: data)
        cell.data = data
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        HapticFeedbackManager.shared.provideFeedback()
        let data = stored[index]
        rfID = data._id //For 컬렉션뷰값전달
        
        let vc = DetailPagerTabViewController()
        
        vc.rfName = data.name
        vc.rfId = data._id
        
        delegate?.pushView(vc: vc)
    }
    
    func pagerViewWillBeginDragging(_ pagerView: FSPagerView) {
        HapticFeedbackManager.shared.provideFeedback()
    }
    
}


extension MainView: SwitchScreenProtocol {
    func switchScreen(nav: UINavigationController) {
        self.window?.rootViewController?.present(nav, animated: true)
    }
}
