//
//  GalleryBottomView.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class GalleryBottoView: UIView {
    enum Dimension {
        static let height: CGFloat = 66
    }
    
    let title = "선택된 항목 %d / \(Static.constant.maxSelectImageCount)개"
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Static.font.title5
        label.textColor = Static.color.fontDarkGray
        label.textAlignment = .center
        return label
    }()
    
    let selectedImageCount = BehaviorRelay<Int>(value: 0)
    let disposeBag = DisposeBag()
    
    init() {
        let frame = CGRect(origin: .zero, size: CGSize(width: Static.dimension.screenWidth, height: Dimension.height))
        super.init(frame: frame)
        setupViews()
        setupObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(24)
        }
    }
    
    private func setupObserver() {
        selectedImageCount
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] selectedImageCount in
                guard let self else { return }
                self.titleLabel.text = String(format: self.title, selectedImageCount)
            })
            .disposed(by: disposeBag)
    }
    
    
    
}
