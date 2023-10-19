//
//  AllPageViewController.swift
//  Pantry
//
//  Created by hoon on 2023/10/09.
//

import UIKit
import BarcodeScanner
import Toast

class AllPageViewController: BaseViewController {
    
    
    let mainView = AllPageView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.switchDelegate = self
        mainView.delegate = self
    }
    
    
    override func configureView() {
        mainView.introDuctionButton.addTarget(self,
                                              action: #selector(introDuctionButtonTapped),
                                              for: .touchUpInside)
        mainView.filterButton.addTarget(self,
                                        action: #selector(filterButtonTapped),
                                        for: .touchUpInside)
    }
    
    override func setConstraints() {
        
    }
    
    @objc private func filterButtonTapped() {
        let bulletinBoardVC = FilterButtonVC.instance()
        bulletinBoardVC.delegate = self
        addDim()
        present(bulletinBoardVC, animated: true)
    }
    
    @objc private func introDuctionButtonTapped() {
        let x = UIScreen.main.bounds.width / 2
        let y = UIScreen.main.bounds.height / 2
        
        mainView.makeToast(NSLocalizedString("introDes", comment: ""),
                           duration: 3.0, point: CGPoint(x: x, y: y),
                           title: NSLocalizedString("introTitle", comment: ""),
                           image: UIImage(named: "ExampleBar"),
                           style: mainView.style,
                           completion: nil)
    }
    
    private func addDim() {
        view.addSubview(mainView.bgView)
        mainView.bgView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.mainView.bgView.alpha = 0.5
        }
    }
    
    private func removeDim() {
        DispatchQueue.main.async { [weak self] in
            self?.mainView.bgView.removeFromSuperview()
        }
    }
    
    
}

extension AllPageViewController: BulletinDelegate {
    func onTapClose() {
        self.removeDim()
    }
}

extension AllPageViewController: SwitchScreenProtocol, NavPushProtocol {
    func pushView(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func switchScreen(nav: UINavigationController) {
        present(nav, animated: true)
    }
    
}
