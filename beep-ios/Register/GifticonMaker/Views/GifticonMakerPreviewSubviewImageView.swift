//
//  GifticonMakerPreviewSubviewImageView.swift
//  beep-ios
//
//  Created by BeomSeok on 1/6/24.
//

import UIKit
import SnapKit

class GifticonMakerPreviewSubviewImageView: UIView {
    enum Dimension {
        static let height: CGFloat = 170
    }
    
    let imageView = UIImageView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "금액권"
        label.textColor = Static.color.fontGray
        label.font = Static.font.body5
        return label
    }()
    let toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = Static.color.beepPink
        toggle.isOn = false
        return toggle
    }()
    
    init() {
        let size = CGSize(width: GIfticonMakerPreview.Dimension.size.width, height: Dimension.height)
        super.init(frame: CGRect(origin: .zero, size: size))
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: GIfticonMakerPreview.Dimension.size.width).isActive = true
        heightAnchor.constraint(equalToConstant: Dimension.height).isActive = true
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(118)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top)
            make.left.equalTo(imageView.snp.right).offset(12)
            make.width.equalTo(32)
            make.height.equalTo(18)
        }
        
        addSubview(toggle)
        toggle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(4)
            make.width.equalTo(32)
            make.height.equalTo(16)
        }
    }
    
    func updateImage(image: UIImage) {
        imageView.image = image
    }
    
}
