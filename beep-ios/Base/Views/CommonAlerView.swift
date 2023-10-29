//
//  CommonAlerView.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/29.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum CommonAlertEvent {
    case cancel, confirm
}

class CommonAlerView: UIView {
    enum Dimension {
        static let buttonSize: CGSize = CGSize(width: 134, height: 54)
    }
    
    let title: String
    let confirmTitle: String
    let cancelTitle: String
    
    let alertEvent = PublishSubject<CommonAlertEvent>()
    let disposeBag = DisposeBag()
    
    init(title: String, confirmTitle: String, cancelTitle: String = "아니요") {
        self.title = title
        self.confirmTitle = confirmTitle
        self.cancelTitle = cancelTitle
        let frame = CGRect(x: 0, y: 0, width: Static.dimension.screenWidth, height: Static.dimension.screenHeight)
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = Static.color.black.withAlphaComponent(0.3)
        
        let containerView = UIView()
        containerView.backgroundColor = Static.color.white
        containerView.layer.cornerRadius = 16
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
            make.height.equalTo(146)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = Static.font.title4
        titleLabel.textAlignment = .left
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.1
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(24)
        }
        
        let cancelButton = makeButton(buttonEvent: .cancel)
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(Dimension.buttonSize.width)
            make.height.equalTo(Dimension.buttonSize.height)
        }
        
        let confirmButton = makeButton(buttonEvent: .confirm)
        addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-24)
            make.width.equalTo(Dimension.buttonSize.width)
            make.height.equalTo(Dimension.buttonSize.height)
        }
        
        self.rx
            .tapGesture(configuration: { gestureRecognizer, delegate in
                delegate.simultaneousRecognitionPolicy = .never
            })
            .when(.recognized)
            .subscribe(onNext: { [weak self] gestureRecognizers in
                guard let self else { return }
                self.alertEvent.onNext(.cancel)
            })
            .disposed(by: disposeBag)
    }
    
    private func makeButton(buttonEvent: CommonAlertEvent) -> UIButton {
        let button = UIButton(frame: CGRect(origin: .zero, size: Dimension.buttonSize))
        button.layer.cornerRadius = 16
        
        let buttonTitle = buttonEvent == .cancel ? cancelTitle : confirmTitle
        let buttonTitleColor = buttonEvent == .cancel ? Static.color.mediuimGray : Static.color.white
        let buttonColor = buttonEvent == .cancel ? Static.color.lightGray : Static.color.beepPink
        
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(buttonTitleColor, for: .normal)
        button.titleLabel?.font = Static.font.title5
        button.backgroundColor = buttonColor
        
        button.rx.tap
            .map({ buttonEvent })
            .bind(to: self.alertEvent)
            .disposed(by: disposeBag)
        
        return button
    }
}
