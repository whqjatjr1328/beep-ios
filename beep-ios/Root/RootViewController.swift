//
//  RootViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import RxSwift
import UIKit

#if DEBUG
import FLEX
#endif

class RootViewController: UIViewController {
    
    var didPermission: Bool = false
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Static.color.beepPink
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
#if DEBUG
        FLEXManager.shared.showExplorer()
#endif

        
        if LoginViewModel.isLogined() == false {
            openLoginViewControlelr()
            return
        }
         
        if didPermission == false {
            openPermissionController()
        }
    }
    
}


extension RootViewController {
    private func openLoginViewControlelr() {
        let loginViewModel = LoginViewModel()
        let loginVC = LoginViewController(loginViewModel: loginViewModel)
        loginVC.modalPresentationStyle = .fullScreen
        
        loginViewModel.didLogin
            .take(1)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                loginVC.dismiss(animated: true) { [weak self] in
                    self?.openPermissionController()
                }
            })
            .disposed(by: disposeBag)
        
        self.present(loginVC, animated: true)
    }
    
    private func openPermissionController() {
        let permissionVC = PermissionViewController()
        permissionVC.modalPresentationStyle = .fullScreen
        
        permissionVC.didRequestPersmission
            .take(1)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.didPermission = true
                permissionVC.dismiss(animated: true) { [weak self] in
                    self?.openHomeViewController()
                }
                
            })
            .disposed(by: disposeBag)
        
        self.present(permissionVC, animated: true)
    }
    
    private func openHomeViewController() {
        let homeVC = MainViewController()
        homeVC.modalPresentationStyle = .fullScreen
        
        self.present(homeVC, animated: true)
    }
}
