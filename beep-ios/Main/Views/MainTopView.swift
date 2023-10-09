//
//  MainTopView.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/09/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainTopView: UIView {
    let loginInfo: LoginInfo
    
    let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Static.font.title2
        label.textAlignment = .left
        return label
    }()
    
    let settings: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(beepNamed: "icon_setting_mono")
        return imageView
    }()
    
    let didTapSettings = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    init(loginInfo: LoginInfo) {
        self.loginInfo = loginInfo
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(thumbnailView)
        thumbnailView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(thumbnailView.snp.right).offset(8)
            make.width.equalTo(220)
        }
    
        addSubview(settings)
        settings.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
            make.width.height.equalTo(18)
        }
        
        settings.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.didTapSettings.onNext(Void())
            })
            .disposed(by: disposeBag)
        
    }
}
