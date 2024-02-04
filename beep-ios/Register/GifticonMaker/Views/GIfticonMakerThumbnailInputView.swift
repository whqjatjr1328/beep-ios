//
//  GIfticonMakerThumbnailInputView.swift
//  beep-ios
//
//  Created by BeomSeok on 2/4/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class GIfticonMakerThumbnailInputView: UIView {
    enum Dimension {
        static let height: CGFloat = 50
    }
    
    let imageView = UIImageView()
    let containerView = UIView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "마땅한 썸네일이 없다면?"
        label.textAlignment = .left
        label.textColor = Static.color.mediuimGray
        label.font = Static.font.subTitle2
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "썸네일 에셋 사용하기"
        label.textAlignment = .left
        label.textColor = Static.color.mediumPink
        label.font = Static.font.body5
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(beepNamed: "Expand_right"), for: .normal)
        return button
    }()
    
    let oepnThumbnailPicker = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: Static.dimension.screenWidth, height: Dimension.height)))
        setupViews()
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = Static.color.lightGray.cgColor
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.width.height.equalTo(50)
        }
        
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = Static.color.lightGray.cgColor
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(13)
            make.right.equalToSuperview().offset(-24)
        }
        
        titleLabel.isUserInteractionEnabled = false
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        subTitleLabel.isUserInteractionEnabled = false
        containerView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(14)
        }
        
        button.isUserInteractionEnabled = false
        containerView.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(20)
        }
    }
    
    func setupObservers() {
        containerView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: {[weak self] _ in
                guard let self else { return }
                self.oepnThumbnailPicker.onNext(())
            })
            .disposed(by: disposeBag)
    }
    
    func updateThumbnail(image: UIImage?) {
        imageView.image = image
    }
    
}

