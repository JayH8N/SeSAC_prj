//
//  OnboardingViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/25.
//

import UIKit

//첫번째 뷰
class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
    }
}

//두번째 뷰
class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
    }
}

//세번째 뷰
class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .magenta
    }
}

class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    

    //1.뷰 배열에 담는다.
    var list: [UIViewController] = []
    
    
    //option: 페이지 넘기는 스타일
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        
        //2.
        list = [FirstViewController(), SecondViewController(), ThirdViewController()]
        
        
        //3.
        delegate = self
        dataSource = self
        
        //5.
        guard let first = list.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
        
    }
    
    
    
    //4.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        
        return previousIndex < 0 ? nil : list[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
        return nextIndex >= list.count ? nil : list[nextIndex]
    }
    
    
    
    //페이지 위치 확인 메서드(.horizontal, .scroll일때만)
    
    //총 몇개
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    //점들 중 현재페이지 위치 나타냄
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = list.firstIndex(of: first) else { return 0 }
        return index
    }
    
    
    

  

}
