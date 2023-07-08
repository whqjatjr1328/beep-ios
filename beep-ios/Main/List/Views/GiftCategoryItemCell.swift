//
//  GiftCategoryItemCell.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/18.
//

import UIKit

class GiftCategoryItemCell: UICollectionViewCell {
    
    var defaultColor: UIColor {
        return UIColor(hexString: "#C9C9C9")
    }
    
    var selectedColor: UIColor {
        return UIColor(hexString: "#727272")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Static.font.titleSmall
        label.textColor = UIColor(hexString: "#C9C9C9")
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 17
        contentView.layer.borderColor = defaultColor.cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setSelected(isSelected: false)
    }
    
    func updateCell(category: String, isSelected: Bool) {
        titleLabel.text = category
        setSelected(isSelected: isSelected)
    }
    
    func setSelected(isSelected: Bool) {
        let color = isSelected ? selectedColor : defaultColor
        titleLabel.textColor = color
        contentView.layer.borderColor = color.cgColor
    }
}
