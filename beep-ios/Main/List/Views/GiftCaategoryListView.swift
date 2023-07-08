//
//  GiftCaategoryListView.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/18.
//

import UIKit
import RxSwift

class GiftCategoryListView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let reueseIdentifier: String = "GiftCategoryListCell"
    
    lazy var listView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.delegate = self
        view.dataSource = self
        view.register(GiftCategoryItemCell.self, forCellWithReuseIdentifier: self.reueseIdentifier)
        return view
    }()
    
    var categories: [String]
    let didSelectGift = PublishSubject<String>()
    
    
    init(gifts: [String]) {
        self.categories = gifts
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(listView)
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func reloadData(newGifts: [String]? = nil) {
        if let newGifts = newGifts {
            categories = newGifts
        }
        
        listView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reueseIdentifier, for: indexPath)
        guard let giftItemCell = cell as? GiftListItemCell else { return cell }
//        giftItemCell.update(image: <#T##UIImage#>, category: <#T##String#>, itemTitle: <#T##String#>, endDate: <#T##Date#>)
        return giftItemCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item < categories.count else { return }
        let selectedGift = categories[indexPath.item]
        didSelectGift.onNext(selectedGift)
    }
}
