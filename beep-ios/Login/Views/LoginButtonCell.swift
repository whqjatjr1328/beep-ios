//
//  LoginButtonCell.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/08/15.
//

import UIKit
import SnapKit

class LoginButtonCell: UICollectionViewCell {
    let iconImageView = UIImageView()
    
    var loginType: LoginType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        iconImageView.backgroundColor = .clear
        iconImageView.contentMode = .scaleAspectFit
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateLoginType(loginType: LoginType) {
        self.loginType = loginType
        iconImageView.image = loginType.icon
    }
}
