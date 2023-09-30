//
//  PermissionViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/08/15.
//

import UIKit
import Photos
import RxSwift
import RxGesture

class PermissionViewController: UIViewController {
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Beep"
        label.font = Static.font.title2
        label.textAlignment = .left
        label.textColor = Static.color.black
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "접근 권한 안내"
        label.font = Static.font.highlight2
        label.textAlignment = .left
        label.textColor = Static.color.grey30
        return label
    }()
    
    var permissionView: PermissionView?
    var descriptionLabel: UILabel?
    var agreeButton: UIButton?
    
    var locationManager: CLLocationManager? = nil
    
    let didRequestPersmission = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = Static.color.bg
        
        view.addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Static.dimension.safeArae.top + 6)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(38)
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(16)
            make.left.equalTo(titleLable.snp.left)
            make.height.equalTo(30)
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
        
        let button = UIButton()
        button.setTitle("동의하고 시작", for: .normal)
        button.setTitleColor(Static.color.whilte, for: .normal)
        button.backgroundColor = Static.color.pink
        button.layer.cornerRadius = 16
        self.agreeButton = button
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(0 - Static.dimension.safeArae.bottom - 12)
            make.centerX.equalToSuperview()
            make.width.equalTo(327)
            make.height.equalTo(16 + 22 + 16)
        }
        
        button.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.requestPermissions()
            })
            .disposed(by: disposeBag)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "허용하지 않아도 서비스를 이용할 수 있으나\n일부 서비스의 이용이 제한 될 수 있습니다."
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = Static.font.subText
        descriptionLabel.textColor = Static.color.grey70
        self.descriptionLabel = descriptionLabel
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(button.snp.top).offset(-20)
            make.left.right.equalToSuperview()
            make.height.equalTo(36)
        }
    }
}

extension PermissionViewController {
    func requestPermissions() {
        requestNotificationAuthorization()
            .flatMap({ _ in self.requestPHPhotoLibraryAuthorization() })
            .subscribe(onSuccess: { [weak self] _ in
                guard let self = self else { return }
                self.requestLocationUsage()
            })
            .disposed(by: disposeBag)
    }
    
    func requestNotificationAuthorization() -> Single<Bool> {
        return Single<Bool>.create { single in
            let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.requestAuthorization(options: authOptions) { success, error in
                if let error = error {
                    print(error)
                }
                
                single(.success(success))
            }
            
            return Disposables.create()
        }
    }
    
    func requestPHPhotoLibraryAuthorization() -> Single<Bool> {
        return Single<Bool>.create { single in
            guard PHPhotoLibrary.authorizationStatus(for: .readWrite) != .authorized else {
                single(.success(true))
                return Disposables.create()
            }
            
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { authorizationStatus in
                switch authorizationStatus {
                case .limited:
                    print("limited authorization granted")
                case .authorized:
                    print("authorization granted")
                default:
                    print("Unimplemented")
                }
                single(.success(true))
            }
            
            return Disposables.create()
        }
    }
    
    func requestLocationUsage() {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        
        guard locationManager.authorizationStatus
        
        locationManager.requestWhenInUseAuthorization()
        self.locationManager = locationManager
    }
}

extension PermissionViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("location auth success")
        case .restricted, .notDetermined:
            print("location auth not set")
        case .denied:
            print("location auth denied")
        default:
            break
        }
        
        self.didRequestPersmission.onNext(())
    }
}
