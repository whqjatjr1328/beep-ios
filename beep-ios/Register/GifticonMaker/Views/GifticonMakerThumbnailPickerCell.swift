//
//  GifticonMakerThumbnailPickerCell.swift
//  beep-ios
//
//  Created by BeomSeok on 2/4/24.
//

import UIKit
import SnapKit

class GifticonMakerThumbnailPickerCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Static.color.mediuimGray
        label.font = Static.font.body3
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
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = Static.color.mediuimGray.cgColor
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(16)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func updateCell(type: GIfticonMakerThumbnailType, isSelected: Bool) {
        contentView.backgroundColor = isSelected ? Static.color.bg : Static.color.white
        imageView.image = type.image
        titleLabel.text = type.title
    }
}
