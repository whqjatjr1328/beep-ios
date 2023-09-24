//
//  PermissionView.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/08/15.
//

import UIKit
import SnapKit

class PermissionView: UIView {
    enum Dimension {
        static let titleHeight: CGFloat = 22
        static let titleBottomMargin: CGFloat = 16
        static let spacing: CGFloat = 15
    }
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.text = "선택 권한 목록"
        label.font = Static.font.title5
        label.textAlignment = .left
        label.textColor = Static.color.grey30
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .clear
        
        addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(Dimension.titleHeight)
        }
        
        var offset: CGFloat = Dimension.titleHeight + Dimension.titleBottomMargin
        for permissionType in PermissionType.allCases {
            let permissionTypeView = PermissionTypeView(permissionType: permissionType)
            addSubview(permissionTypeView)
            permissionTypeView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(offset)
                make.left.right.equalToSuperview()
                make.height.equalTo(PermissionTypeView.Dimension.size.height)
            }
            
            offset += PermissionTypeView.Dimension.size.height
            offset += Dimension.spacing
        }
    }
}
