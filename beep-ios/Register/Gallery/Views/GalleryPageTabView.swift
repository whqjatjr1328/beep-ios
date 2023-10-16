//
//  GalleryPageTabView.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class GalleryPageTabView: UIView {
    var recommendButton: GalleryPageButton?
    var albumButton: GalleryPageButton?
    
    let selectedPage = BehaviorRelay<GalleryPageType>(value: .all)
    let disposeBag = DisposeBag()
    
    init() {
        let frame = CGRect(origin: .zero, size: CGSize(width: Static.dimension.screenWidth, height: 40))
        super.init(frame: frame)
        setupViews()
        setupObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let recommendButton = GalleryPageButton(pageType: .recommend)
        addSubview(recommendButton)
        recommendButton.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalTo(Static.dimension.screenWidth / 2)
            make.height.equalTo(40)
        }
        
        recommendButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                self.selectedPage.accept(.recommend)
            })
            .disposed(by: disposeBag)
        
        self.recommendButton = recommendButton
        
        let albumButton = GalleryPageButton(pageType: .all)
        addSubview(albumButton)
        albumButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.equalTo(Static.dimension.screenWidth / 2)
            make.height.equalTo(40)
        }
        
        albumButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                self.selectedPage.accept(.all)
            })
            .disposed(by: disposeBag)
        
        self.albumButton = albumButton
    }
    
    func setupObserver() {
        selectedPage
            .distinctUntilChanged()
            .bind(onNext: { [weak self] pageType in
                guard let self else { return }
                self.recommendButton?.isSelected = pageType == .recommend
                self.albumButton?.isSelected = pageType == .all
            })
            .disposed(by: disposeBag)
    }
    
}
