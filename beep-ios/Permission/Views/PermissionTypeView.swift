//
//  PermissionTypeView.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/08/15.
//

import UIKit

class PermissionTypeView: UIView {
    enum Dimension {
        static let size: CGSize = CGSize(width: 263, height: 76)
    }
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.font = Static.font.subTitle
        label.textAlignment = .left
        label.textColor = Static.color.grey30
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Static.font.body4
        label.textAlignment = .left
        label.textColor = Static.color.grey30
        return label
    }()
    
    let iconImageView = UIImageView()
    
    let permissionType: PermissionType
    
    init(permissionType: PermissionType) {
        self.permissionType = permissionType
        super.init(frame: CGRect(origin: .zero, size: Dimension.size))
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = Static.color.whilte
        layer.cornerRadius = 12
        
        let iconBgView = UIView()
        iconBgView.backgroundColor = permissionType.iconBGColor.withAlphaComponent(0.1)
        iconBgView.layer.cornerRadius = 8
        iconBgView.layer.masksToBounds = true
        addSubview(iconBgView)
        iconBgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }
        
        iconImageView.image = permissionType.icon
        iconBgView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLable.text = permissionType.title
        addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.left.equalTo(iconBgView.snp.right).offset(13)
            make.height.equalTo(20)
        }
        
        descriptionLabel.text = permissionType.description
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(4)
            make.left.right.equalTo(titleLable)
            make.height.equalTo(20)
        }
    }
    
}
