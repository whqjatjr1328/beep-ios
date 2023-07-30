//
//  LoginViewModel.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/07/30.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class LoginViewModel {
    
    let animationCount = LoginAnimationType.allCases.count
    let loginAnimations = BehaviorRelay<[LoginAnimationType]>(value: [.third, .first, .second, .third, .first])
    let loginButtonTypes = BehaviorRelay<[LoginType]>(value: LoginType.allCases)
    
    let selectedLoginButton = PublishSubject<LoginType>()
    
    let disposeBag = DisposeBag()
    
    
    init() {
        
    }
    
    func configureLoginAnimatinoList(listView: UICollectionView) {
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<Int, LoginAnimationType>> { [weak self] datasource, collectionView, indexPath, item in
            guard let self = self else { return LoginImageCell() }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LoginImageCell.self), for: indexPath)
            
            if let animationCell = cell as? LoginImageCell {
                let loginAnimation = self.loginAnimations.value[indexPath.item]
                animationCell.updateCell(type: loginAnimation)
            }
            
            return cell
        }
        
        loginAnimations
            .map({ [SectionModel(model: 0, items: $0)] })
            .bind(to: listView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
    }
    
    func validAnimationIndex(index: Int) -> Int {
        let idx = index % animationCount
        return idx > 0 ? idx : idx + animationCount
    }
}
