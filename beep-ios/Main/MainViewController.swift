//
//  MainViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import RIBs
import RxSwift
import UIKit

protocol MainPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class MainViewController: UITabBarController, MainPresentable, MainViewControllable {

    weak var listener: MainPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = Static.color.whilte
        let listViewController = ListViewController()
        let homeViewController = HomeViewController()
        let settingsViewController = SettingsViewController()
        
        listViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        settingsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        setViewControllers([listViewController, homeViewController, settingsViewController], animated: false)
        selectedIndex = 1
        
        
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.backgroundColor = Static.color.whilte
        
        tabBar.standardAppearance = tabbarAppearance
        tabBar.isTranslucent = false 
    }
    
    
}
