//
//  GifticonMakeButton.swift
//  beep-ios
//
//  Created by BeomSeok on 12/28/23.
//

import UIKit
import SnapKit

class GifticonMakeButton: UIView {
    enum Dimension {
        static let size = CGSize(width: 327, height: 54)
    }
    
    var isAvailable: Bool = false {
        didSet {
            updateViews()
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Static.font.title5
        label.textColor = Static.color.mediuimGray
        return label
    }()
    
    init() {
        let frame = CGRect(origin: .zero,
                           size: Dimension.size)
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.cornerRadius = 16
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        updateAvailable(gifticonCount: 0)
    }
    
    private func updateViews() {
        backgroundColor = isAvailable ? Static.color.beepPink : Static.color.lightGray
        titleLabel.textColor = isAvailable ? Static.color.white : Static.color.mediuimGray
    }
    
    func updateAvailable(gifticonCount: Int) {
        isAvailable = gifticonCount > 0
        titleLabel.text = isAvailable ? "\(gifticonCount)개 쿠폰 등록하기" : "쿠폰 등록하기"
    }
}
