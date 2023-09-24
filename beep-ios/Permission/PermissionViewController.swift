//
//  PermissionViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/08/15.
//

import UIKit
import RxSwift
import RxGesture

class PermissionViewController: UIViewController {
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.text = "접근 권한 안내"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.textColor = Static.color.black
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이용을 위해 접근 권한을 허용해 주세요"
        label.font = Static.font.titleSmall
        label.textAlignment = .center
        label.textColor = Static.color.grey30
        return label
    }()
    
    var permissionView: PermissionView?
    var descriptionLabel: UILabel?
    var agreeButton: UIButton?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(125)
            make.height.equalTo(28)
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        let permissionView = PermissionView()
        view.addSubview(permissionView)
        permissionView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.width.equalTo(246)
            make.height.equalTo(256)
        }
        self.permissionView = permissionView
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "허용하지 않아도 서비스를 이용할 수 있으나\n일부 서비스의 이용이 제한 될 수 있습니다."
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = Static.font.bodySmall
        descriptionLabel.textColor = Static.color.grey70
        self.descriptionLabel = descriptionLabel
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(permissionView.snp.bottom).offset(156)
            make.centerX.equalToSuperview()
            make.width.equalTo(211)
            make.height.equalTo(32)
        }
        
        let button = UIButton()
        button.setTitle("동의하고 시작", for: .normal)
        button.setTitleColor(Static.color.whilte, for: .normal)
        button.backgroundColor = Static.color.pink
        button.layer.cornerRadius = 16
        self.agreeButton = button
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(312)
            make.height.equalTo(54)
        }
        
        button.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
            })
            .disposed(by: disposeBag)
    }
    
    
    
}
