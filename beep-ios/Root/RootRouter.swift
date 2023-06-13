//
//  RootRouter.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import RIBs

protocol RootInteractable: Interactable, LogOutListener, MainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    // MARK: - Private

    private let logoutBuilder: LogOutBuildable
    private var logout: ViewableRouting?
    
    private var mainBuilder: MainBuildable
    private var main: ViewableRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         logoutBuilder: LogOutBuildable,
         mainBuilder: MainBuildable) {
        self.logoutBuilder = logoutBuilder
        self.mainBuilder = mainBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        let logout = logoutBuilder.build(withListener: interactor)
        attachChild(logout)
        self.logout = logout
        viewController.present(viewController: logout.viewControllable)
    }
    
    func routeToMain() {
        if let logout = logout {
            detachChild(logout)
            viewController.dismiss(viewController: logout.viewControllable)
        }
        
        let main = mainBuilder.build(withListener: interactor)
        attachChild(main)
        self.main = main
        viewController.present(viewController: main.viewControllable)
    }
}
