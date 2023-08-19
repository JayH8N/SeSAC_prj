//
//  TVMainViewController.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit

class TVMainViewController: UIViewController {

    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       settingButtonTVside()
        searchBar.delegate = self
        searchBar.isHidden = true
    }
    
    

    

}
