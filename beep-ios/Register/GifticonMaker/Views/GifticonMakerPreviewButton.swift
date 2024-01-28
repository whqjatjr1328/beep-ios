//
//  GifticonMakerPreviewButton.swift
//  beep-ios
//
//  Created by BeomSeok on 12/10/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class GifticonMakerPreviewButton: UIView {
    enum Dimension {
        static let maxWidth: CGFloat = 98
        static let minWidth: CGFloat = 38
        static let height: CGFloat = 34
    }
    
    let iconView: UIImageView = {
        let image = UIImage(beepNamed: "File_dock_search_fill")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Static.font.body1
        label.textAlignment = .center
        label.text = "미리보기"
        return label
    }()
    
    var isSelected: Bool = false
    
    init() {
        let frame = CGRect(origin: .zero, size: CGSize(width: Dimension.maxWidth, height: Dimension.height))
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        layer.cornerRadius = 17
        layer.borderWidth = 1.0
        layer.borderColor = Static.color.beepPink.cgColor
        
        addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(9)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(4)
            make.centerY.equalToSuperview()
            make.width.equalTo(56)
            make.height.equalTo(20)
        }
        
        updateUI()
    }
    
    func updateSelected(isSelected: Bool) {
        guard self.isSelected != isSelected else { return }
        self.isSelected = isSelected
        updateUI()
    }
    
    func updateUI() {
        self.backgroundColor = isSelected ? Static.color.beepPink.withAlphaComponent(0.1) : Static.color.beepPink
        iconView.tintColor = isSelected ? Static.color.beepPink : Static.color.white
        titleLabel.textColor = isSelected ? Static.color.beepPink : Static.color.white
    }
    
    func validWidth(width: CGFloat) -> CGFloat {
        let validWidth = max(Dimension.minWidth, min(width, Dimension.maxWidth))
        self.frame.size.width = width
        let alpha = 1 - (Dimension.maxWidth - validWidth) / (Dimension.maxWidth - Dimension.minWidth)
        titleLabel.alpha = alpha
        return validWidth
    }
}
