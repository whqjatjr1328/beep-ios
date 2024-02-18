//
//  GifticonMakerCropHandler.swift
//  beep-ios
//
//  Created by BeomSeok on 2/10/24.
//

import UIKit
import SnapKit

enum GifticonMakerCropHandlerType {
    case topLeft, topRight
    case bottomLeft, bottomRight
    
    var backgroundColor: UIColor {
        switch self {
        case .topLeft: return .blue
        case .topRight: return .yellow
        case .bottomLeft: return .red
        case .bottomRight: return .green
        }
    }
}

class GifticonMakerCropHandler: UIView {
    let type: GifticonMakerCropHandlerType
    
    let horizontalHander: UIView = UIView()
    let verticalHander: UIView = UIView()
    
    init(type: GifticonMakerCropHandlerType) {
        self.type = type
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: Static.dimension.cropHanderWidth, height: Static.dimension.cropHanderWidth)))
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        horizontalHander.backgroundColor = type.backgroundColor // Static.color.beepPink
        addSubview(horizontalHander)
        horizontalHander.snp.makeConstraints { make in
            if self.type == .topLeft || self.type == .topRight {
                make.top.equalToSuperview()
            } else if self.type == .bottomLeft || self.type == .bottomRight {
                make.bottom.equalToSuperview()
            }
            make.left.right.equalToSuperview()
            make.height.equalTo(4)
        }
        
        verticalHander.backgroundColor = Static.color.beepPink
        addSubview(verticalHander)
        verticalHander.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            if self.type == .topLeft || self.type == .bottomLeft {
                make.left.equalToSuperview()
            } else if self.type == .topRight || self.type == .bottomRight {
                make.right.equalToSuperview()
            }
            make.width.equalTo(4)
        }
    }
}
