//
//  Case2.swift
//  SeSAC_Week3
//
//  Created by hoon on 2023/09/17.
//

import UIKit
import SnapKit


class Case2: UIViewController {
    
    var 전체설정: [String] = ["공지사항", "실험실", "버전정보"]
    var 개인설정: [String] = ["개인/보안", "알림", "채팅", "멀티프로필"]
    var 기타: [String] = ["고객센터/도움말"]
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        configureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0, 1, 2])
        snapshot.appendItems(전체설정, toSection: 0)
        snapshot.appendItems(개인설정, toSection: 1)
        snapshot.appendItems(기타, toSection: 2)
        dataSource.apply(snapshot)
        
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    static private func layout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>  { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            
            var header = UIListContentConfiguration.plainHeader()
            header.text = "전체설정"
            
            
            content.text = itemIdentifier
            
            cell.contentConfiguration = content
            
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
    }
    
}
