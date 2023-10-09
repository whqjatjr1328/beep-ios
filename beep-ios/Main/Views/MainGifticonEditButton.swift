//
//  MainGifticonEditButton.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/09.
//

import UIKit
import SnapKit

class MainGifticonEditButton: UIView {
    let editLabel: UILabel = {
        let label = UILabel()
        label.text = "편집"
        label.textColor = Static.color.mediuimGray
        label.textAlignment = .left
        label.font = Static.font.body3
        return label
    }()
    
    let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(beepNamed: "icon_pencil_mono")
        return imageView
    }()
    
    init() {
        let frame = CGRect(origin: .zero, size: CGSize(width: 47, height: 20))
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(editLabel)
        editLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.centerY.right.equalToSuperview()
            make.width.height.equalTo(18)
        }
    }
}
