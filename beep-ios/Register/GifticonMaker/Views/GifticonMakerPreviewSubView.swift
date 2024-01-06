//
//  GifticonMakerPreviewSubView.swift
//  beep-ios
//
//  Created by BeomSeok on 12/28/23.
//

import UIKit
import SnapKit

class GifticonMakerPreviewSubView: UIView {
    enum Dimension {
        static let minimumHeight: CGFloat = 30
    }
    
    let titleLabel: GifticonMakerPreviewSubviewTitle
    let contentLabel = GifticonMakerPreviewSubviewLabel()
    
    var heightConstraint: NSLayoutConstraint?
    
    init(title: String) {
        self.titleLabel = GifticonMakerPreviewSubviewTitle(title: title)
        let frame = CGRect(origin: .zero,
                           size: CGSize(width: GIfticonMakerPreview.Dimension.size.width, height: Dimension.minimumHeight))
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        widthAnchor.constraint(equalToConstant: GIfticonMakerPreview.Dimension.size.width).isActive = true
        let heightConstraint = heightAnchor.constraint(equalToConstant: Dimension.minimumHeight)
        heightConstraint.isActive = true
        self.heightConstraint = heightConstraint
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(40)
            make.height.equalTo(22)
        }
        
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(13)
            make.right.equalToSuperview()
        }
    }
    
    func updateContent(content: String) {
        let contentLabelHeight = contentLabel.updateText(text: content)
        self.heightConstraint?.constant = max(contentLabelHeight, Dimension.minimumHeight)
    }
    
}
