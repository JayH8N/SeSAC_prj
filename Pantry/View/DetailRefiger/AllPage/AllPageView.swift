//
//  AllPageView.swift
//  Pantry
//
//  Created by hoon on 2023/10/09.
//

import UIKit
import Then
import SnapKit
import JJFloatingActionButton
import BarcodeScanner

class AllPageView: BaseView {
    
    
    weak var switchDelegate: SwitchScreenProtocol?
    weak var delegate: didSelectProtocol?
    
//MARK: - Properties
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    lazy var allCollectionView = UICollectionView(frame: .zero, collectionViewLayout: allCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(ItemsCell.self, forCellWithReuseIdentifier: ItemsCell.identifier)
    }
    

    let filterButton = UIButton.makeHighlightedButton(withImageName: "slider.horizontal.3", size: 34).then {
        $0.tintColor = .black
    }
    
    
    
    
    lazy var actionButton = JJFloatingActionButton().then {
        $0.buttonImage = UIImage(systemName: "plus")
        $0.buttonColor = UIColor.black
        
        
        $0.addItem(title: NSLocalizedString("AddItem", comment: ""),
                   image: UIImage(systemName: "square")) { _ in
            let vc = AddItemViewController()
            let nav = UINavigationController(rootViewController: vc)
            
            self.switchDelegate?.switchScreen(nav: nav)
        }
        
        $0.addItem(title: NSLocalizedString("addItemBarcode", comment: ""),
                   image: UIImage(systemName: "barcode.viewfinder")) { _ in
            let barcodeScanner = self.makeBarcodeScannerVC()
            self.delegate?.pushView(vc: barcodeScanner)
               
        }
        
        $0.buttonImageSize = CGSize(width: 40, height: 40)
    }
    
    private func makeBarcodeScannerVC() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        return viewController
    }
    
    
    override func configureView() {
        super.configureView()
        addSubview(blurEffect)
        addSubview(filterButton)
        addSubview(allCollectionView)
        addSubview(actionButton)
        
    }
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        filterButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(4)
            $0.leading.equalTo(self.snp.leading).inset(18)
        }
        
        allCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterButton.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        actionButton.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).inset(30)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(30)
        }
        
    }
    
    
}

extension AllPageView {
    private func allCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        let size = UIScreen.main.bounds.width - 36
        layout.itemSize = CGSize(width: size / 2, height: (size / 2) * 0.7)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 12, right: 12)
        return layout
    }
}

extension AllPageView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCell.identifier, for: indexPath) as! ItemsCell
        
        return cell
    }
    
    
}

extension AllPageView: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    func scanner(_ controller: BarcodeScanner.BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("Barcode====== \(code)")
        print("Type======= \(type)")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            controller.reset()
            controller.navigationController?.popViewController(animated: true)
            
            let vc = AddItemViewController()
            let nav = UINavigationController(rootViewController: vc)
            
            self.switchDelegate?.switchScreen(nav: nav)
        }
    }

    func scanner(_ controller: BarcodeScanner.BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }

    func scannerDidDismiss(_ controller: BarcodeScanner.BarcodeScannerViewController) {
        controller.dismiss(animated: true)
    }

}
