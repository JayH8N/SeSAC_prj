//
//  BookCollectionViewController.swift
//  BOOKWARM
//
//  Created by hoon on 2023/07/31.
//

import UIKit

class BookCollectionViewController: UICollectionViewController {

    let searchBar = UISearchBar()
    
    
    var searchList: [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    } // [String] -> list에서 유저가 검색한 영화
    
    
    var movie = MovieInfo() {
        didSet { //변수가 달라짐을 감지!
            collectionView.reloadData()
        }
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView  = searchBar
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요"
        searchBar.showsCancelButton = true
        
        let nib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        
        setLayout()
    }
    
    
    
    
    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 14
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        
        collectionView.collectionViewLayout = layout
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController
        
        vc.searchContents = "검색화면"
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: MovieInfoViewController.identifier) as! MovieInfoViewController
        
        //let row = searchList[indexPath.row]
        vc.type = .push
        vc.title = searchList[indexPath.row].title
        vc.Poster = searchList[indexPath.row].image
        vc.mTitle = searchList[indexPath.row].title
        vc.overview = searchList[indexPath.row].overview
        vc.movieRate = searchList[indexPath.row].rate
        vc.rTime = searchList[indexPath.row].runtime
        vc.rDate = searchList[indexPath.row].releaseDate
        
        navigationController?.pushViewController(vc, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        
        let row = searchList[indexPath.row]
        cell.setCell(row: row)
        cell.setLikeButton(data: row)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        searchList[sender.tag].like.toggle()
    }
    
}



extension BookCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchList.removeAll()
        
        for item in movie.movie {
            if item.title.contains(searchBar.text!) {
                searchList.append(item)
            }
        }
    }
    
    //취소버튼 누르면 서치바 텍스트 내용 비우기 + 뷰 화면 clear시키는 기능
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchList.removeAll()
        searchBar.text = ""
        //collectionView.reloadData()
    }
    
    //실시간 검색
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        for item in movie.movie {
            if item.title.contains(searchBar.text!) {
                searchList.append(item)
            } else if searchBar.text == "" {
                searchList.removeAll()
                //서치바 텍스트가 비워지면 collectioinView clear시킴
            }
        }
    }
}
