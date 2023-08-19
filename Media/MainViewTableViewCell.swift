//
//  MainViewTableViewCell.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit

class MainViewTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var mainBackView: UIView!
    @IBOutlet var mainPosterView: UIImageView!
    @IBOutlet var pinnedButton: UIButton!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var rateScoreLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var actorsLabel: UILabel!
    @IBOutlet var subBackView: UIView!
    @IBOutlet var subBackViewTitleLabel: UILabel!
    @IBOutlet var subBackViewImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }

    func setCell() {
        func setLabel() {
            dateLabel.textColor = .systemGray5
            dateLabel.font = .systemFont(ofSize: 10)
            genreLabel.font = .boldSystemFont(ofSize: 13)
            rateLabel.textColor = .white
            rateLabel.font = .systemFont(ofSize: 10)
            rateLabel.textAlignment = .center
            rateLabel.backgroundColor = UIColor(red: 124/255, green: 91/255, blue: 245/255, alpha: 1)
            rateScoreLabel.font = .systemFont(ofSize: 10)
            rateScoreLabel.textAlignment = .center
            rateScoreLabel.backgroundColor = .white
            titleLabel.font = .systemFont(ofSize: 15)
            actorsLabel.textColor = .systemGray5
            actorsLabel.font = .systemFont(ofSize: 12)
            subBackViewTitleLabel.text = "자세히 보기"
            subBackViewTitleLabel.font = .systemFont(ofSize: 10)
        }
        
        func setImageView() {
            mainPosterView.layer.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
            subBackViewImage.image = UIImage(systemName: "chevron.forward")
            subBackViewImage.tintColor = .systemGray5
        }
        
        func setUIView() {
            mainBackView.layer.cornerRadius = 10
            mainBackView.layer.shadowColor = UIColor.black.cgColor   //그림자 색깔
            mainBackView.layer.shadowOffset = CGSize(width: 0, height: 0)  //태양이 보는 시점
            mainBackView.layer.shadowRadius = 10  //그림자 코너깎임정도
            mainBackView.layer.shadowOpacity = 0.5   //그림자 투명도
            subBackView.layer.addBorder([.top], width: 0.7, color: UIColor.systemGray5.cgColor)
        }
        
        func setUIButton() {
            pinnedButton.setImage(UIImage(systemName: "paperclip.circle.fill"), for: .normal)
            pinnedButton.tintColor = .white
        }
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
