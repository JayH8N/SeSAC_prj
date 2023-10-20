//
//  DetailPagerTab.swift
//  Pantry
//
//  Created by hoon on 2023/10/09.
//

import UIKit
import Tabman
import Pageboy

import SnapKit
import JJFloatingActionButton
import BarcodeScanner
import Toast

class DetailPagerTabViewController: TabmanViewController, PageboyViewControllerDataSource {
    
    
    private var viewControllers: Array<UIViewController> = []
    
    var rfName: String = ""
    
    let introDuctionButton = UIButton.makeHighlightedButton(withImageName: "questionmark.circle", size: 25).then {
        $0.tintColor = .darkGray
    }
    
    var style = {
        var view = ToastStyle()
        view.backgroundColor = UIColor.toastColor
        view.imageSize = CGSize(width: 80, height: 120)
        view.titleColor = .black
        view.messageColor = .black
        return view
    }()
    
    lazy var actionButton = JJFloatingActionButton().then {
        $0.buttonImage = UIImage(systemName: "plus")
        $0.buttonColor = UIColor.black
        
        $0.addItem(title: NSLocalizedString("AddItem", comment: ""),
                   image: UIImage(systemName: "square")) { [weak self] _ in
            
            HapticFeedbackManager.shared.provideFeedback()
            let vc = AddItemViewController()
            let nav = UINavigationController(rootViewController: vc)
            
            //self?.switchDelegate?.switchScreen(nav: nav)
            self?.present(nav, animated: true)
        }
        
        $0.addItem(title: NSLocalizedString("addItemBarcode", comment: ""),
                   image: UIImage(systemName: "barcode.viewfinder")) { [weak self] _ in
            HapticFeedbackManager.shared.provideFeedback()
            let barcodeScanner = self?.makeBarcodeScannerVC()
            //self?.delegate?.pushView(vc: barcodeScanner!)
            self?.navigationController?.pushViewController(barcodeScanner!, animated: true)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabman()
        configureView()
        title = rfName
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: introDuctionButton)
        introDuctionButton.addTarget(self, action: #selector(introDuctionButtonTapped), for: .touchUpInside)
    }
    
    private func configureView() {
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.trailing.equalTo(view.snp.trailing).inset(30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
        }
    }
    
    @objc private func introDuctionButtonTapped() {
        let x = UIScreen.main.bounds.width / 2
        let y = UIScreen.main.bounds.height / 2
        
        self.view.makeToast(NSLocalizedString("introDes", comment: ""),
                            duration: 3.0, point: CGPoint(x: x, y: y),
                            title: NSLocalizedString("introTitle", comment: ""),
                            image: UIImage(named: "ExampleBar"),
                            style: self.style,
                            completion: nil)
    }
    
}

extension DetailPagerTabViewController {
    private func configureTabman() {
        let vc1 = AllPageViewController()
        let vc2 = RefrigerPageViewController()
        let vc3 = FreezerPageViewController()
        
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        
        bar.buttons.customize { button in
            button.tintColor = .lightGray
            button.selectedTintColor = .black
        }
        
        bar.indicator.weight = .custom(value: 3)
        bar.indicator.overscrollBehavior = .none
        bar.indicator.tintColor = .black
        
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
}


extension DetailPagerTabViewController: TMBarDataSource {
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        let item = TMBarItem(title: "")
        
        let all = NSLocalizedString("All", comment: "")
        let refriger = NSLocalizedString("Refrigerator", comment: "")
        let freezer = NSLocalizedString("Freezer", comment: "")
        
        let titles = [all, refriger, freezer]
        item.title = titles[index]
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
}

extension DetailPagerTabViewController: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    func scanner(_ controller: BarcodeScanner.BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("Barcode====== \(code)")
        print("Type======= \(type)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            controller.reset()
            controller.navigationController?.popViewController(animated: true)
            
            let vc = AddItemViewController()
            let nav = UINavigationController(rootViewController: vc)
            
            //self.switchDelegate?.switchScreen(nav: nav)
            self.present(nav, animated: true)
        }
    }
    
    func scanner(_ controller: BarcodeScanner.BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScanner.BarcodeScannerViewController) {
        controller.dismiss(animated: true)
    }
    
}
