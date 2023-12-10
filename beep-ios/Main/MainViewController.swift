//
//  MainViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/09/30.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    var topView: MainTopView?
    
    let gifticonListView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionHeadersPinToVisibleBounds = true
        
        let listView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        listView.register(MainGifticonListByLocation.self, forCellWithReuseIdentifier: String(describing: MainGifticonListByLocation.self))
        listView.register(MainGifticonListCell.self, forCellWithReuseIdentifier: String(describing: MainGifticonListCell.self))
        listView.register(MainGifticonListHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: MainGifticonListHeader.self))
        listView.register(MainGifticonListFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: MainGifticonListFooter.self))
        return listView
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(beepNamed: "floating_btn"), for: .normal)
        return button
    }()
    
    var gifticons: [Gifticon] = []
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservers()
    }
    
    func setupViews() {
        view.backgroundColor = Static.color.white
        
        let topView = MainTopView(loginInfo: LoginInfo(id: "", name: ""))
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Static.dimension.safeArae.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.topView = topView
        
        gifticonListView.dataSource = self
        gifticonListView.delegate = self
        view.addSubview(gifticonListView)
        gifticonListView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.right.equalToSuperview().offset(-24)
            make.width.height.equalTo(60)
        }
        
    }
    
    func setupObservers() {
        addButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.didTapAddButton()
            })
            .disposed(by: disposeBag)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return gifticons.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        if indexPath.section == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainGifticonListByLocation.self), for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainGifticonListCell.self), for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: MainGifticonListHeader.self), for: indexPath)
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: MainGifticonListFooter.self), for: indexPath)
            return footer
        }
    }
    
    
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 1 ? CGSize(width: Static.dimension.screenWidth, height: MainGifticonListHeader.Dimension.height) : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return section == 0 ? MainGifticonListFooter.Dimension.size : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return MainGifticonListByLocation.Dimension.size
        } else {
            return MainGifticonListCell.Dimension.size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .zero
        } else {
            return UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension MainViewController {
    func didTapAddButton() {
        let registerVC = RegisterNavigationController()
        registerVC.modalPresentationStyle = .fullScreen
        self.present(registerVC, animated: true)
    }
}
