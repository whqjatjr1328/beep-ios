//
//  MainGifticonListFooter.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/17.
//

import UIKit
import SnapKit

class MainGifticonListFooter: UICollectionReusableView {
    enum Dimension {
        static let size = CGSize(width: Static.dimension.screenWidth, height: 70)
    }
    
    var title: String {
        return "사용 기한이 임박했어요"
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Static.font.title5
        return label
    }()
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(beepNamed: "today_24px")
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
        let titleWidth = title.size(boundingSize: CGSize(width: Static.dimension.screenWidth, height: 22), font: Static.font.title5).width
        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(ceil(titleWidth))
            make.height.equalTo(22)
        }
        
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(4)
            make.width.height.equalTo(16)
        }
    }
}
