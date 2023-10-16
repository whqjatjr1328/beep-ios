//
//  BaseSelectButton.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/17.
//

import UIKit

class BaseSelectButton: UIView {
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
    
    let title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        titleLabel.text = title
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
