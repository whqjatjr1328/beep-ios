//
//  LoginButton.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/17.
//

import UIKit
import SnapKit
import RxGesture

class LoginButton: UIView {
    enum Dimension {
        static let size: CGSize = CGSize(width: 328, height: 44)
        static let radius: CGFloat = 20
        static let iconMargin: CGFloat = 12
        static let iconWidth: CGFloat = 34
    }
    
    let loginType: LoginType
    
    var icon: UIImageView?
    var title: UILabel?
    
    init(loginType: LoginType) {
        self.loginType = loginType
        super.init(frame: CGRect(origin: .zero, size: Dimension.size))
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = loginType.backgroundColor
        self.layer.cornerRadius = Dimension.radius
        self.layer.masksToBounds = true
        
        let icon = UIImageView(image: loginType.iconImage)
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Dimension.iconMargin)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(Dimension.iconWidth)
        }
        self.icon = icon
        
        let title = UILabel()
        title.font = Static.font.bodyMedium
        title.textColor = loginType.titleColor
        title.textAlignment = .center
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.1
        title.text = loginType.title
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.title = title
    }
}
