//
//  MainViewTableViewCell.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit
import Kingfisher

class MainViewTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var mainBackView: UIView!
    @IBOutlet var mainPosterView: UIImageView!
    @IBOutlet var pinnedButton: UIButton!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var rateScoreLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var originalTitle: UILabel!
    @IBOutlet var actorsLabel: UILabel!
    @IBOutlet var subBackView: UIView!
    @IBOutlet var subBackViewTitleLabel: UILabel!
    @IBOutlet var subBackViewImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
        setImageView()
        setUIView()
        setUIButton()
    }

    
        func setLabel() {
            dateLabel.textColor = .lightGray
            dateLabel.font = .systemFont(ofSize: 13)
            genreLabel.font = .boldSystemFont(ofSize: 18)
            rateLabel.textColor = .white
            rateLabel.font = .systemFont(ofSize: 10)
            rateLabel.textAlignment = .center
            rateLabel.backgroundColor = UIColor(red: 124/255, green: 91/255, blue: 245/255, alpha: 1)
            rateLabel.text = "Rate"
            rateScoreLabel.font = .systemFont(ofSize: 10)
            rateScoreLabel.textAlignment = .center
            rateScoreLabel.backgroundColor = .white
            titleLabel.font = .systemFont(ofSize: 20)
            originalTitle.font = .systemFont(ofSize: 20)
            originalTitle.textColor = .green
            actorsLabel.textColor = .lightGray
            actorsLabel.font = .systemFont(ofSize: 14)
            subBackViewTitleLabel.text = "Details"
            subBackViewTitleLabel.font = .systemFont(ofSize: 13)
        }
        
        func setImageView() {
            mainPosterView.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
            mainPosterView.contentMode = .scaleToFill
            subBackViewImage.image = UIImage(systemName: "chevron.forward")
            subBackViewImage.tintColor = .lightGray
        }
        
        func setUIView() {
            mainBackView.layer.cornerRadius = 10
            mainBackView.layer.shadowColor = UIColor.black.cgColor   //그림자 색깔
            mainBackView.layer.shadowOffset = CGSize(width: 0, height: 0)  //태양이 보는 시점
            mainBackView.layer.shadowRadius = 10  //그림자 코너깎임정도
            mainBackView.layer.shadowOpacity = 0.5   //그림자 투명도
            subBackView.layer.addBorder([.top], width: 0.7, color: UIColor.lightGray.cgColor)
        }
        
        func setUIButton() {
            pinnedButton.setImage(UIImage(systemName: "paperclip.circle.fill"), for: .normal)
            pinnedButton.tintColor = .white
            pinnedButton.contentVerticalAlignment = .fill
            pinnedButton.contentHorizontalAlignment = .fill
        }
    
    
    func setCelldata(data: TmdbData) {
        dateLabel.text = data.releaseDate
        if let url = URL(string: URL.imageBaseURL + data.backdropPath) {
            mainPosterView.kf.setImage(with: url)
        }
        rateScoreLabel.text = "\(data.voteAverage)"
        actorsLabel.text = data.overview
        titleLabel.text = data.title
        originalTitle.text = data.originalTitle
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MainViewTableViewCell: Reusableidentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
