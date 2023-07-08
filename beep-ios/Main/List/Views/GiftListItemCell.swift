//
//  GiftListItemCell.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/18.
//

import UIKit
import SnapKit

class GiftListItemCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = Static.font.bodySmall
        label.textColor = UIColor(hexString: "#B0B0B0")
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Static.font.titleSmall
        label.textColor = UIColor(hexString: "#454545")
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    let endDateLabel: UILabel = {
        let label = UILabel()
        label.font = Static.font.bodySmall
        label.textColor = UIColor(hexString: "#B0B0B0")
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    let dDayLabel: UILabel = {
        let label = UILabel()
        label.font = Static.font.bodySmall
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.backgroundColor = UIColor(hexString: "#939094")
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 4
        contentView.layer.borderColor = UIColor(hexString: "#D1D1D1").cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dDayLabel)
        contentView.addSubview(endDateLabel)
        
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(9)
            make.centerY.equalToSuperview()
            make.width.equalTo(99)
            make.height.equalTo(73)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(imageView.snp.right).offset(14)
            make.right.equalToSuperview()
            make.height.equalTo(13)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(3)
            make.left.right.equalTo(categoryLabel)
            make.height.equalTo(17)
        }
        
        endDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalTo(categoryLabel)
            make.height.equalTo(16)
        }
        
        dDayLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(26)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(image: UIImage, category: String, itemTitle: String, endDate: Date) {
        imageView.image = image
        categoryLabel.text = category
        titleLabel.text = itemTitle
        endDateLabel.text = "~ \(endDate)"
        
        let calendar = Calendar.current
        let today = Date()
        let startDate = calendar.startOfDay(for: today)
        let targetDate = calendar.startOfDay(for: endDate)

        let numberOfDays = calendar.dateComponents([.day], from: startDate, to: targetDate)
        dDayLabel.text = "D - \(numberOfDays)"

    }
}
