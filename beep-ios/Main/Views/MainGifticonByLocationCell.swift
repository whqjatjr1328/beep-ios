//
//  MainGifticonByLocationCell.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/09.
//

import UIKit

class MainGifticonByLocationCell: UICollectionViewCell {
    enum Dimension {
        static let size = CGSize(width: 136, height: 184)
    }
    
    let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Static.font.body1
        label.textColor = Static.color.fontDarkGray
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Static.font.body5
        label.textColor = Static.color.fontGray
        return label
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
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = Static.color.lightGray.cgColor
        
        contentView.addSubview(thumbnailView)
        thumbnailView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(118)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(15)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(33)
        }
    }
    
    
    func update(gifticon: Gifticon) {
        thumbnailView.image = UIImage(contentsOfFile: gifticon.croppedUrl)
        titleLabel.text = gifticon.displayBrand
        descriptionLabel.text = gifticon.name
    }
}
