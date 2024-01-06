//
//  GifticonMakerFiledListCell.swift
//  beep-ios
//
//  Created by BeomSeok on 12/10/23.
//

import UIKit
import SnapKit

class GifticonMakerFiledListCell: UICollectionViewCell {
    let iconView = UIImageView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Static.font.body1
        label.textAlignment = .center
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
        contentView.layer.cornerRadius = 17
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = Static.color.lightGray.cgColor
        contentView.backgroundColor = Static.color.bg
        
        titleLabel.textColor = Static.color.fontMediumGray
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateCell(title: String, isSelected: Bool) {
        titleLabel.text = title
        contentView.layer.borderColor = isSelected ? Static.color.beepPink.cgColor : Static.color.lightGray.cgColor
        contentView.backgroundColor = isSelected ? Static.color.beepPink.withAlphaComponent(0.1) : Static.color.bg
        titleLabel.textColor = isSelected ? Static.color.beepPink : Static.color.fontMediumGray
    }
}
