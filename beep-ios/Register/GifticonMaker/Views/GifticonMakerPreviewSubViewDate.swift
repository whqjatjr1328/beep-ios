//
//  GifticonMakerPreviewSubViewDate.swift
//  beep-ios
//
//  Created by BeomSeok on 1/6/24.
//

import UIKit
import SnapKit

class GifticonMakerPreviewSubViewDate: GifticonMakerPreviewSubView {
    
    let cashLabel: GifticonMakerPreviewSubviewTitle
    let cashAmountLabel = GifticonMakerPreviewSubviewLabel()
    
    init() {
        let title = GifticonField.expireDate.title
        cashLabel = GifticonMakerPreviewSubviewTitle(title: GifticonField.totalCash.title)
        super.init(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(50)
            make.height.equalTo(22)
        }
        
        contentLabel.snp.remakeConstraints { make in
            make.top.bottom.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(3)
            make.width.equalTo(84)
        }
        
        addSubview(cashLabel)
        cashLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(titleLabel)
            make.left.equalTo(contentLabel.snp.right).offset(4)
            make.width.equalTo(53)
        }
        
        addSubview(cashAmountLabel)
        cashAmountLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(titleLabel)
            make.left.equalTo(cashLabel.snp.right).offset(4)
            make.right.equalToSuperview()
        }
        
        showCash(isShow: false)
    }
    
    func showCash(isShow: Bool) {
        cashLabel.isHidden = isShow == false
        cashAmountLabel.isHidden = isShow == false
    }
}
