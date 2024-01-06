//
//  GifticonMakerTextInputView.swift
//  beep-ios
//
//  Created by BeomSeok on 1/7/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class GifticonMakerTextInputView: UIView {
    
    let bgView = UIView()
    let inputBarBg = UIView()
    let inputFieldBg = UIView()
    let inputField: UITextField = {
        let textField = UITextField()
        textField.textColor = Static.color.fontDarkGray
        textField.textAlignment = .left
        textField.font = Static.font.body1
        textField.text = ""
        return textField
    }()
    
    var currentText: String {
        return inputField.text ?? ""
    }
    
    var inputFieldBottomConstraint: Constraint?
    
    let hasMaximumLength: Bool
    let didEndTextEdit = PublishSubject<String>()
    let dispoesBag = DisposeBag()
    
    init(initailText: String, hasMaxinumLength: Bool) {
        self.hasMaximumLength = hasMaxinumLength
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: Static.dimension.screenWidth, height: Static.dimension.screenHeight)))
        self.inputField.text = initailText
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        bgView.backgroundColor = Static.color.black.withAlphaComponent(0.3)
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        inputBarBg.backgroundColor = Static.color.white
        addSubview(inputBarBg)
        inputBarBg.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(78)
            self.inputFieldBottomConstraint = make.bottom.equalToSuperview().offset(0).constraint
        }
        
        inputFieldBg.layer.cornerRadius = 8
        inputFieldBg.backgroundColor = Static.color.bg
        inputBarBg.addSubview(inputFieldBg)
        inputFieldBg.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-9)
        }
        
        inputField.backgroundColor = .clear
        inputField.delegate = self
        inputFieldBg.addSubview(inputField)
        inputField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(16)
            
        }
        
        
        setupObserver()
    }
    
    func beginEdit() {
        inputField.becomeFirstResponder()
    }
    
    func setupObserver() {
        bgView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.inputField.resignFirstResponder()
            })
                    .disposed(by: dispoesBag)
        
        let keyBoardWillShow = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .map { notification -> CGFloat in
                return (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0 + Static.dimension.safeArae.bottom
            }
        
        let keyboardWillHide = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map({ _ in return CGFloat(0) })
        
        Observable.merge(keyBoardWillShow, keyboardWillHide)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] height in
                guard let self else { return }
                self.didUpdateKeyboard(keybaordHeight: height)
            })
            .disposed(by: dispoesBag)

    }
    
    func didUpdateKeyboard(keybaordHeight: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.inputFieldBg.alpha = keybaordHeight == 0 ? 0.0 : 1.0
            self.inputFieldBottomConstraint?.update(offset: -keybaordHeight)
        }
    }
    
    func endTextEdit() {
        self.didEndTextEdit.onNext(self.currentText)
    }
}

extension GifticonMakerTextInputView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.didEndTextEdit.onNext(self.currentText)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
