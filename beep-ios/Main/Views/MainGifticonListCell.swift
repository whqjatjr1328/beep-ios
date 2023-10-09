//
//  MainGifticonListCell.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/10.
//

import UIKit

class MainGifticonListCell: UICollectionViewCell {
    enum Dimension {
        static let size = CGSize(width: 327, height: 88)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Static.color.fontDarkGray
        label.textAlignment = .left
        label.font = Static.font.body1
        return label
    }()
    
    let brandLabel: UILabel = {
        let label = UILabel()
        label.textColor = Static.color.mediumPink
        label.textAlignment = .left
        label.font = Static.font.body5
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Static.color.mediuimGray
        label.textAlignment = .left
        label.font = Static.font.subText
        return label
    }()
    
    let dDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = Static.color.mediuimGray
        label.textAlignment = .center
        label.font = Static.font.body5
        label.backgroundColor = Static.color.bg
        label.layer.cornerRadius = 8
        return label
    }()
    
    let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.layer.cornerRadius = 16
        
        contentView.addSubview(thumbnailView)
        thumbnailView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(98)
            make.height.equalTo(72)
        }
        
        contentView.addSubview(brandLabel)
        brandLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(thumbnailView.snp.right).offset(12)
            make.right.equalToSuperview()
            make.height.equalTo(18)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom)
            make.left.right.equalTo(brandLabel)
            make.height.equalTo(37)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalTo(brandLabel)
            make.height.equalTo(17)
        }
        
        contentView.addSubview(dDayLabel)
        dDayLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.equalTo(47)
            make.height.equalTo(26)
        }
    }
    
    func updateCell(gifticon: Gifticon) {
        thumbnailView.image = UIImage(contentsOfFile: gifticon.originUrl)
        brandLabel.text = gifticon.displayBrand
        titleLabel.text = gifticon.name
        dateLabel.text = "\(gifticon.expireAt)"
        
        let numberOfDays = Calendar.current.dateComponents([.day], from: Date(), to: gifticon.expireAt).day
        dDayLabel.text = "D-\(numberOfDays ?? 0)"
    }
}
