//
//  LogOutRouter.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import RIBs

protocol LogOutInteractable: Interactable {
    var router: LogOutRouting? { get set }
    var listener: LogOutListener? { get set }
}

protocol LogOutViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class LogOutRouter: ViewableRouter<LogOutInteractable, LogOutViewControllable>, LogOutRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: LogOutInteractable, viewController: LogOutViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
