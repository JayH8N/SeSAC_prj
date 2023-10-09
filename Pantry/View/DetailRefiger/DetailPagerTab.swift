//
//  DetailPagerTab.swift
//  Pantry
//
//  Created by hoon on 2023/10/09.
//

import UIKit
import Tabman
import Pageboy

class DetailPagerTabViewController: TabmanViewController, PageboyViewControllerDataSource {
    
    
    private var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabman()
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
        
        bar.indicator.weight = .custom(value: 5)
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
