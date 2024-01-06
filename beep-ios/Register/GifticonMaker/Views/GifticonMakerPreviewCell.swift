//
//  GifticonMakerPreviewCell.swift
//  beep-ios
//
//  Created by BeomSeok on 1/6/24.
//

import UIKit
import SnapKit

class GifticonMakerPreviewCell: UICollectionViewCell {
    let preview = GIfticonMakerPreview()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.layer.cornerRadius = 18
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = Static.color.lightGray.cgColor
        contentView.layer.shadowColor = UIColor(hexString: "#888888").cgColor
        contentView.layer.shadowOpacity = 1.0
        contentView.layer.shadowRadius = 18
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.addSubview(preview)
        preview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
