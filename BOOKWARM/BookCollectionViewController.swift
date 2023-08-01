//
//  BookCollectionViewController.swift
//  BOOKWARM
//
//  Created by hoon on 2023/07/31.
//

import UIKit

class BookCollectionViewController: UICollectionViewController {

    var movie = MovieInfo() {
        didSet { //변수가 달라짐을 감지!
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        vc.self.title = movie.movie[indexPath.row].title
        vc.Poster = movie.movie[indexPath.row].image
        vc.mTitle = movie.movie[indexPath.row].title
        vc.overview = movie.movie[indexPath.row].overview
        vc.movieRate = movie.movie[indexPath.row].rate
        vc.rTime = movie.movie[indexPath.row].runtime
        vc.rDate = movie.movie[indexPath.row].releaseDate
        
        navigationController?.pushViewController(vc, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.movie.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        
        let row = movie.movie[indexPath.row]
        cell.setCell(row: row)
        cell.setLikeButton(data: row)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        movie.movie[sender.tag].like.toggle()
    }
    
}
