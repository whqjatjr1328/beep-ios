//
//  GalleryTopView.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum GalleryTopViewAction {
    case cancel, select
}

class GalleryTopView: UIView {
    enum Dimension {
        static let height: CGFloat = 44
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "사진 선택"
        label.font = Static.font.title2
        label.textAlignment = .center
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(beepNamed: "Close_round"), for: .normal)
        return button
    }()
    
    let selectButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("선택", for: .normal)
        button.setTitleColor(Static.color.fontGray, for: .normal)
        button.setTitleColor(Static.color.fontDarkGray, for: .disabled)
        button.titleLabel?.font = Static.font.subTitle1
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let selectButtonEnabled = BehaviorRelay<Bool>(value: false)
    let didSelectTopButton = PublishSubject<GalleryTopViewAction>()
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
    
    func setupViews() {
        addSubview(title)
        title.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(19)
            make.width.height.equalTo(20)
        }
        
        let selectButtonWidth = "선택".size(boundingSize: CGSize(width: Static.dimension.screenWidth, height: 26), font: Static.font.subTitle1).width
        addSubview(selectButton)
        selectButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
            make.width.equalTo(ceil(selectButtonWidth))
            make.height.equalTo(26)
        }
    }
    
    func setupObserver() {
        cancelButton.rx.tap
            .map({ return GalleryTopViewAction.cancel })
            .bind(to: didSelectTopButton)
            .disposed(by: disposeBag)
        
        selectButton.rx.tap
            .map({ return GalleryTopViewAction.select })
            .bind(to: didSelectTopButton)
            .disposed(by: disposeBag)
        
        selectButtonEnabled
            .distinctUntilChanged()
            .bind(onNext: { [weak self] isEnabled in
                guard let self else { return }
                self.selectButton.isEnabled = isEnabled
            })
            .disposed(by: disposeBag)
    }
    
}
