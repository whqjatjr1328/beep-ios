//
//  RootViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import RxSwift
import UIKit


class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Static.color.main
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let loginViewModel = LoginViewModel()
        
        if loginViewModel.isLogined() == false {
            let loginVC = LoginViewController(loginViewModel: loginViewModel)
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
            return
        }
        
        let permissionVC = PermissionViewController()
        permissionVC.modalPresentationStyle = .fullScreen
        self.present(permissionVC, animated: true)
        
    }
    
    
    
}
