//
//  LogOutViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import SnapKit

protocol LogOutPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func didTapLogin()
}

final class LogOutViewController: UIViewController, LogOutPresentable, LogOutViewControllable {

    weak var listener: LogOutPresentableListener?
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Static.font.titleLarge
        label.textColor = Static.color.black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.text = "Beep"
        return label
    }()
    
    var subTitle: UILabel = {
        let label = UILabel()
        label.font = Static.font.titleMedium
        label.textColor = Static.color.black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.text = "기프티콘 관리를 한번에"
        return label
    }()
    
    var logoImage = UIImageView()
    
    
    var naverLogin: UIButton?
    var kakaoLogin: UIButton?
    var googleLogin: UIButton?
    var appleLogin: UIButton?
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = Static.color.whilte
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(176)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(subTitle)
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.left.right.equalToSuperview()
            make.height.equalTo(24)
        }
        
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(34)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(144)
        }
        
        var bottomOffset: CGFloat = 224
        let loginTypes: [LoginType] = [.naver, .kakao, .google, .apple]
        for loginType in loginTypes {
            let button = LoginButton(loginType: loginType)
            view.addSubview(button)
            button.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.size.equalTo(LoginButton.Dimension.size)
                make.bottom.equalToSuperview().offset(-bottomOffset)
            }
            
            button.rx.tapGesture()
                .when(.recognized)
                .subscribe(onNext: { [weak self] _ in
                    self?.listener?.didTapLogin()
                })
                .disposed(by: self.disposeBag)
            
            bottomOffset -= (LoginButton.Dimension.size.height + 10)
        }
    }
    
}
