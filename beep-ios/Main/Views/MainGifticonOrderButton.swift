//
//  MainGifticonOrderButton.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/09.
//

import UIKit
import RxSwift

enum MainGifticonListOrder: CaseIterable {
    case dDay, recent
    
    var title: String {
        switch self {
        case .dDay:     return "디데이순"
        case .recent:   return "최신등록순"
        }
    }
}

class MainGifticonOrderButton: UIView {
    var isSelected: Bool = false {
        didSet {
            updateView()
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Static.font.body3
        return label
    }()
    
    let seperator = UIView()
    
    let order: MainGifticonListOrder
    
    init(order: MainGifticonListOrder) {
        self.order = order
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        titleLabel.text = order.title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(seperator)
        seperator.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        updateView()
    }
    
    func updateView() {
        titleLabel.textColor = isSelected ? Static.color.black : Static.color.fontMediumGray
        seperator.backgroundColor = isSelected ? Static.color.black : Static.color.lightGray
    }
}
