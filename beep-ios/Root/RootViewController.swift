//
//  RootViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import RxSwift
import UIKit


class RootViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Static.color.main
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if LoginViewModel.isLogined() == false {
            openLoginViewControlelr()
            return
        }
         
        openPermissionController()
    }
    
}


extension RootViewController {
    private func openLoginViewControlelr() {
        let loginViewModel = LoginViewModel()
        let loginVC = LoginViewController(loginViewModel: loginViewModel)
        loginVC.modalPresentationStyle = .fullScreen
        
        loginViewModel.didLogin
            .take(1)
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
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                permissionVC.dismiss(animated: true) { [weak self] in
                    self?.openHomeViewController()
                }
                
            })
            .disposed(by: disposeBag)
        
        self.present(permissionVC, animated: true)
    }
    
    private func openHomeViewController() {
        
    }
}
