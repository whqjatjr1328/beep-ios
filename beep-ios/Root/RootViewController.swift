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
        
        loginViewModel.didLogin
            .take(1)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.presentingViewController?.dismiss(animated: false)
                self.openPermissionController()
            })
            .disposed(by: disposeBag)
        
        let loginVC = LoginViewController(loginViewModel: loginViewModel)
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    
    private func openPermissionController() {
        let permissionVC = PermissionViewController()
        permissionVC.modalPresentationStyle = .fullScreen
        self.present(permissionVC, animated: true)
    }
}
