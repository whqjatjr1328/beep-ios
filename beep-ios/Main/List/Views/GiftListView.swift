//
//  GiftListView.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/18.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class GiftListView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let reueseIdentifier: String = " GiftListItemCell"
    
    lazy var listView: UICollectionView = {
        let size = CGSize(width: 333, height: 88)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = size
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = .zero
        flowLayout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: CGRect(origin: .zero, size: size), collectionViewLayout: flowLayout)
        view.delegate = self
        view.dataSource = self
        view.register(GiftListItemCell.self, forCellWithReuseIdentifier: self.reueseIdentifier)
        return view
    }()
    
    var gifts: [String]
    let didSelectGift = PublishSubject<String>()
    
    
    init(gifts: [String]) {
        self.gifts = gifts
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
            gifts = newGifts
        }
        
        listView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reueseIdentifier, for: indexPath)
        guard let giftItemCell = cell as? GiftListItemCell else { return cell }
//        giftItemCell.update(image: <#T##UIImage#>, category: <#T##String#>, itemTitle: <#T##String#>, endDate: <#T##Date#>)
        return giftItemCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item < gifts.count else { return }
        let selectedGift = gifts[indexPath.item]
        didSelectGift.onNext(selectedGift)
    }
}
