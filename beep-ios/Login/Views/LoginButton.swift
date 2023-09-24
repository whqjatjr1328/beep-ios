//
//  LoginButton.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/07/30.
//

import UIKit
import SnapKit

class LoginButton: UIView {
    enum Dimension {
        static let size: CGSize = CGSize(width: 320, height: 40)
    }
    
    let iconImageView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    var subTitleLabel: UILabel?
    
    let loginType: LoginType
    
    init(loginType: LoginType) {
        self.loginType = loginType
        super.init(frame: CGRect(origin: .zero, size: Dimension.size))
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = loginType.bgColor
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        iconImageView.image = loginType.icon
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        titleLabel.text = loginType.title
        titleLabel.textColor = loginType.textColor
        titleLabel.textAlignment = .center
        titleLabel.font = Static.font.title5
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if loginType == .custom {
            iconImageView.snp.remakeConstraints { make in
                make.right.equalToSuperview().offset(-24)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(16)
            }
            
            titleLabel.textAlignment = .left
            titleLabel.font = Static.font.body3
            titleLabel.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.left.right.equalToSuperview().inset(34)
            }
            
            let subTitleLabel = UILabel()
            subTitleLabel.text = "비회원 로그인"
            subTitleLabel.textColor = Static.color.grey30
            subTitleLabel.textAlignment = .left
            subTitleLabel.font = Static.font.body3
            addSubview(subTitleLabel)
            subTitleLabel.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.right.equalTo(iconImageView.snp.left)
                make.width.equalTo(68)
            }
            self.subTitleLabel = subTitleLabel
        }
    }
}
