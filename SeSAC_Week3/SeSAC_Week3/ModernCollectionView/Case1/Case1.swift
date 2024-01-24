//
//  Case1.swift
//  SeSAC_Week3
//
//  Created by hoon on 2023/09/17.
//

import UIKit
import SnapKit


class Case1: UIViewController {
    
    let section1 = [Case1View(image: "moon.fill", title: "방해금지모드", subTitle: "켬"),
    Case1View(image: "bed.double.fill", title: "수면", subTitle: nil),
    Case1View(image: "iphone.gen2", title: "업무", subTitle: "09:00 ~ 06:00"),
    Case1View(image: "person.fill", title: "개인 시간", subTitle: "설정")]

    let section2 = [Case1View(image: nil, title: "모든 기기에서 공유", subTitle: nil)]
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    var dataSource: UICollectionViewDiffableDataSource<Int, Case1View>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "집중 모드"
        
        setCollecitonView()
        configureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Case1View>()
        snapshot.appendSections([0, 1])
        snapshot.appendItems(section1, toSection: 0)
        snapshot.appendItems(section2, toSection: 1)
        dataSource.apply(snapshot)
        
    }
    
    private func setCollecitonView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    static private func layout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Case1View>  { cell, indexPath, itemIdentifier in
        
            var content = UIListContentConfiguration.valueCell()
            
            if let image = itemIdentifier.image {
                content.image = UIImage(systemName: image)
                if image == "moon.fill" {
                    content.imageProperties.tintColor = .purple
                } else if image == "bed.double.fill" {
                    content.imageProperties.tintColor = .orange
                } else if image == "iphone.gen2" {
                    content.imageProperties.tintColor = .green
                } else if image == "person.fill" {
                    content.imageProperties.tintColor = .blue
                }
            }
            
            content.text = itemIdentifier.title
            if itemIdentifier.title == "모든 기기에서 공유" {
                var item = UISwitch()
                //???: - UIswitch
            }
            
            
            content.textProperties.font = .systemFont(ofSize: 14)
            
            if let subTitle = itemIdentifier.subTitle {
                if subTitle == "09:00 ~ 06:00" {
                    content.prefersSideBySideTextAndSecondaryText = false
                    content.secondaryText = subTitle
                } else {
                    content.prefersSideBySideTextAndSecondaryText = true
                    content.secondaryText = subTitle
                }
            }
            
            cell.accessories = [.disclosureIndicator()]
            cell.contentConfiguration = content
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView , cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        
        
    }
    
    
    
}
