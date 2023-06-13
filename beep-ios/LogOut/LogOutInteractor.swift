//
//  LogOutInteractor.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import RIBs
import RxSwift

protocol LogOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LogOutPresentable: Presentable {
    var listener: LogOutPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LogOutListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didTapLogin()
}

final class LogOutInteractor: PresentableInteractor<LogOutPresentable>, LogOutInteractable, LogOutPresentableListener {

    weak var router: LogOutRouting?
    weak var listener: LogOutListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LogOutPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapLogin() {
        listener?.didTapLogin()
    }
}
