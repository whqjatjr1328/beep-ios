//
//  LogOutViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol LogOutPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class LogOutViewController: UIViewController, LogOutPresentable, LogOutViewControllable {

    weak var listener: LogOutPresentableListener?
    var naverLogin: UIButton?
    var kakaoLogin: UIButton?
    var googleLogin: UIButton?
    var appleLogin: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = Static.color.main
        
        let naver = makeButton(title: "naver")
        view.addSubview(naver)
        naver.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-173)
            make.height.equalTo(50)
        }
        self.naverLogin = naver
        
        let kakao = makeButton(title: "kakao")
        view.addSubview(kakao)
        kakao.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-113)
            make.height.equalTo(50)
        }
        self.kakaoLogin = kakao
        
        let google = makeButton(title: "google")
        view.addSubview(google)
        google.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-53)
            make.height.equalTo(50)
        }
        self.googleLogin = google
        
//        let apple = makeButton(title: "apple")
//        view.addSubview(apple)
//        apple.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(15)
//            make.right.equalToSuperview().offset(-15)
//            make.bottom.equalToSuperview().offset(-173)
//            make.height.equalTo(50)
//        }
//        self.appleLogin = apple
    }
    
    
    func makeButton(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(Static.color.black, for: .normal)
        button.titleLabel?.font = Static.font.bodyMedium
        
        return button
    }
    
}
