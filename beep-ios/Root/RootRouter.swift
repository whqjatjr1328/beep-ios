//
//  RootRouter.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import RIBs

protocol RootInteractable: Interactable, LogOutListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    // MARK: - Private

    private let logoutBuilder: LogOutBuildable

    private var logout: ViewableRouting?
    

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable, viewController: RootViewControllable, logoutBuilder: LogOutBuilder) {
        self.logoutBuilder = logoutBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        let logout = logoutBuilder.build(withListener: interactor)
        attachChild(logout)
        viewController.present(viewController: logout.viewControllable)
    }
}
