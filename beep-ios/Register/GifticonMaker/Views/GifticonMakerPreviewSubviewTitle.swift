//
//  GifticonMakerPreviewSubviewTitle.swift
//  beep-ios
//
//  Created by BeomSeok on 1/6/24.
//

import UIKit
import SnapKit

class GifticonMakerPreviewSubviewTitle: GifticonMakerPreviewSubviewLabel {
    let title: String
    
    init(title: String) {
        self.title = title
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = Static.color.bg
        layer.cornerRadius = 6
        
        label.font = Static.font.body5
        label.textColor = Static.color.fontDarkGray
        label.textAlignment = .center
        label.numberOfLines = 1
        label.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
        }
        
        
        updateText(text: title)
    }
}
