//
//  GifticonBrandListCell.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/09.
//

import UIKit

class GifticonBrandListCell: UICollectionViewCell {
    enum Dimension {
        static let height: CGFloat = 35
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Static.font.body1
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
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = Static.color.lightGray.cgColor
        contentView.layer.cornerRadius = 17
        contentView.backgroundColor = Static.color.bg
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateView(title: String, isSelected: Bool) {
        titleLabel.text = title
        
        titleLabel.textColor = isSelected ? Static.color.beepPink : Static.color.fontMediumGray
        contentView.backgroundColor = isSelected ? Static.color.beepPink.withAlphaComponent(0.1) : Static.color.bg
        contentView.layer.borderColor = isSelected ? Static.color.beepPink.cgColor : Static.color.lightGray.cgColor
    }
}
