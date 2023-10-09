//
//  MainViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/09/30.
//

import UIKit

class MainViewController: UIViewController {
    var topView: MainTopView?
    
    let gifticonListView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let listView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        listView.register(MainGifticonListByLocation.self, forCellWithReuseIdentifier: String(describing: MainGifticonListByLocation.self))
        listView.register(MainGifticonListCell.self, forCellWithReuseIdentifier: String(describing: MainGifticonListCell.self))
        listView.register(MainGifticonListHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: MainGifticonListHeader.self))
        return listView
    }()
    
    var gifticons: [Gifticon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservers()
    }
    
    func setupViews() {
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
        
    }
    
    func setupObservers() {
        
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
        <#code#>
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
    
}
