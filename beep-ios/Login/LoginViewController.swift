//
//  LoginViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/07/23.
//

import UIKit
import SnapKit
import RxSwift
import RxGesture
import AdvancedPageControl

class LoginViewController: UIViewController {
    enum Dimension {
        static let animationViewWidth: CGFloat = 150
        static let loginButtonWidth: CGFloat = 44
        static let loginButtonSpacing: CGFloat = 16
    }
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Beep"
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textAlignment = .center
        label.textColor = Static.color.black
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "기프티콘을 한번에 관리해요"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = Static.color.grey30
        return label
    }()
    
    let animationListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Dimension.animationViewWidth, height: Dimension.animationViewWidth)
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let listView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        listView.register(LoginImageCell.self, forCellWithReuseIdentifier: String(describing: LoginImageCell.self))
        listView.isPagingEnabled = true
        listView.showsHorizontalScrollIndicator = false
        return listView
    }()
    
    let pageControl: AdvancedPageControlView = {
        let pageControl = AdvancedPageControlView()
        pageControl.drawer = WormDrawer(numberOfPages: 3, indicatorColor: Static.color.main)
        return pageControl
    }()
    
    let loginButtonTitle: UILabel = {
        let label = UILabel()
        label.text = "로그인 방법 선택"
        label.font = Static.font.bodyMedium
        label.textAlignment = .center
        label.textColor = Static.color.grey50
        return label
    }()
    
    let loginButtonList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Dimension.loginButtonWidth, height: Dimension.loginButtonWidth)
        layout.minimumLineSpacing = Dimension.loginButtonSpacing
        layout.minimumInteritemSpacing = Dimension.loginButtonSpacing
        layout.scrollDirection = .horizontal
        let listView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        listView.register(LoginButtonCell.self, forCellWithReuseIdentifier: String(describing: LoginButtonCell.self))
        listView.isPagingEnabled = true
        listView.isScrollEnabled = false
        listView.showsHorizontalScrollIndicator = false
        return listView
    }()
    
    var customLoginButton: LoginButton?
    
    let loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Static.color.whilte
        
        view.addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Static.dimension.safeArae.top + 100)
            make.left.right.equalToSuperview()
            make.height.equalTo(24)
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(6)
            make.left.right.equalToSuperview()
            make.height.equalTo(24)
        }
        
        view.addSubview(animationListView)
        animationListView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(Dimension.animationViewWidth)
        }
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(animationListView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
//            make.width.equalTo(40)
            make.left.right.equalToSuperview()
            make.height.equalTo(8)
        }
        
        view.addSubview(loginButtonTitle)
        loginButtonTitle.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(90)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        view.addSubview(loginButtonList)
        let loginButtonCount = CGFloat(loginViewModel.loginButtonTypes.value.count)
        let loginButtonListWidth = loginButtonCount * (Dimension.loginButtonWidth + Dimension.loginButtonSpacing) - Dimension.loginButtonSpacing
        loginButtonList.snp.makeConstraints { make in
            make.top.equalTo(loginButtonTitle.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(loginButtonListWidth)
            make.height.equalTo(Dimension.loginButtonWidth)
        }
        
        let customLoginButton = LoginButton(loginType: .custom)
        view.addSubview(customLoginButton)
        customLoginButton.snp.makeConstraints { make in
            make.top.equalTo(loginButtonList.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(LoginButton.Dimension.size)
        }
        self.customLoginButton = customLoginButton
        
        
        setupBinding()
        setupObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playCurrentAnimation()
    }
    
    func setupBinding() {
        animationListView.delegate = self
        loginViewModel.configureLoginAnimatinoList(listView: animationListView)
        animationListView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
        
        loginViewModel.configureLoginButtonList(listView: loginButtonList)
        
        self.customLoginButton?.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.loginViewModel.selectedLoginButton.onNext(.custom)
            })
            .disposed(by: disposeBag)
        
    }
    
    func setupObserver() {
        loginViewModel.selectedLoginButton
            .subscribe(onNext: { [weak self] loginType in
                guard let self = self else { return }
                switch loginType {
                
                case .naver: break
                case .kakao: break
                case .google: break
                case .apple: break
                case .custom: break
                }
            })
            .disposed(by: disposeBag)
    }
    
}

extension LoginViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == animationListView {
            stopCurrentAnimation()
        }
        
        let currentIndexPath = currentIndexPath()
        let pageIndex = loginViewModel.validAnimationIndex(index: currentIndexPath.item) - 1
        pageControl.setPage(pageIndex)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == animationListView {
            let currentIndexPath = currentIndexPath()
            let validIndex = loginViewModel.validAnimationIndex(index: currentIndexPath.item)
            
            if currentIndexPath.item != validIndex {
                animationListView.scrollToItem(at: IndexPath(item: validIndex, section: 0), at: .centeredVertically, animated: false)
            }
            
            playCurrentAnimation()
        }
    }
    
    func currentIndexPath() -> IndexPath {
        let currentContentOffset = animationListView.contentOffset
        return animationListView.indexPathForItem(at: CGPoint(x: currentContentOffset.x + Dimension.animationViewWidth / 2, y: currentContentOffset.y)) ?? IndexPath(item: 0, section: 0)
    }
    
    func stopCurrentAnimation() {
        animationListView.visibleCells.forEach { cell in
            if let loginAnimationCell = cell as? LoginImageCell {
                loginAnimationCell.stopAnimation()
            }
        }
    }
    
    func playCurrentAnimation() {
        animationListView.visibleCells.forEach { cell in
            if let loginAnimationCell = cell as? LoginImageCell {
                loginAnimationCell.playAnimation()
            }
        }
    }
}
