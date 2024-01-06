//
//  GifticonMakerPreviewSubviewLabel.swift
//  beep-ios
//
//  Created by BeomSeok on 1/6/24.
//

import UIKit
import SnapKit

class GifticonMakerPreviewSubviewLabel: UIView {
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Static.color.fontDarkGray
        label.font = Static.font.body1
        label.numberOfLines = 0
        return label
    }()
    
    init() {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: Static.dimension.screenWidth, height: 20)))
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }
    
    @discardableResult
    func updateText(text: String) -> CGFloat {
        label.text = text
        label.sizeToFit()
        return ceil(label.frame.height)
    }
    
}
