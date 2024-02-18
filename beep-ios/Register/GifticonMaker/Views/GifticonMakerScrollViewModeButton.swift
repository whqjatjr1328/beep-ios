//
//  GifticonMakerScrollViewModeButton.swift
//  beep-ios
//
//  Created by BeomSeok on 2/12/24.
//

import UIKit
import SnapKit

class GifticonMakerScrollViewModeButton: UIView {
    enum Dimension {
        static let size: CGSize = CGSize(width: 35 + 8 + 42, height: 35)
    }
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Static.color.white
        label.font = Static.font.body5
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let imageView = UIImageView()
    
    var buttonMode: GifticonMakerScrollViewMode
    
    init(buttonMode: GifticonMakerScrollViewMode) {
        self.buttonMode = buttonMode
        super.init(frame: CGRect(origin: .zero, size: Dimension.size))
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(Dimension.size.height)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(42)
        }
        
        setButtonMode(mode: buttonMode)
    }
    
    func setButtonMode(mode: GifticonMakerScrollViewMode) {
        self.buttonMode = mode
        imageView.image = buttonMode.icon
        titleLabel.text = buttonMode.title
    }
}
