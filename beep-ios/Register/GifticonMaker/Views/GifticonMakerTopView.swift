//
//  GifticonMakerTopView.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/29.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum GifticonMakerTopViewAction {
    case cancel
}

class GifticonMakerTopView: UIView {
    enum Dimension {
        static let height: CGFloat = 44
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "쿠폰 등록"
        label.font = Static.font.title2
        label.textAlignment = .center
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(beepNamed: "Close_round"), for: .normal)
        return button
    }()
    
    let didSelectTopButton = PublishSubject<GifticonMakerTopViewAction>()
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
    }
    
    func setupObserver() {
        cancelButton.rx.tap
            .map({ return GifticonMakerTopViewAction.cancel })
            .bind(to: didSelectTopButton)
            .disposed(by: disposeBag)
    }
}
