//
//  MainGifticonListHeader.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/09.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa



class MainGifticonListHeader: UICollectionReusableView {
    enum Dimension {
        static let height: CGFloat = 140
    }
     
    var dDayButton: MainGifticonOrderButton?
    var recentButton: MainGifticonOrderButton?
    var editButton = MainGifticonEditButton()
    
    let brandList: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionViewLayout.minimumInteritemSpacing = 8
        collectionViewLayout.minimumLineSpacing = 8
        
        let listView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        listView.register(GifticonBrandListCell.self, forCellWithReuseIdentifier: String(describing: GifticonBrandListCell.self))
        return listView
    }()
    
    var brands: [String] = ["전체"]
    
    let selectedBrand = BehaviorRelay<String>(value: "")
    let selectedOrder = BehaviorRelay<MainGifticonListOrder>(value: .dDay)
    let didTapEditButton = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let dDayButton = MainGifticonOrderButton(order: .dDay)
        addSubview(dDayButton)
        dDayButton.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalTo(Static.dimension.screenWidth / 2)
            make.height.equalTo(40)
        }
        
        dDayButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.selectedOrder.accept(.dDay)
            })
            .disposed(by: disposeBag)
        
        self.dDayButton = dDayButton
        
        let recentButton = MainGifticonOrderButton(order: .recent)
        addSubview(recentButton)
        recentButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.equalTo(Static.dimension.screenWidth / 2)
            make.height.equalTo(40)
        }
        
        recentButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.selectedOrder.accept(.recent)
            })
            .disposed(by: disposeBag)
        
        self.recentButton = recentButton
        
        
        brandList.dataSource = self
        brandList.delegate = self
        addSubview(brandList)
        brandList.snp.makeConstraints { make in
            make.top.equalTo(dDayButton.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.height.equalTo(GifticonBrandListCell.Dimension.height)
        }
        
        addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.top.equalTo(brandList.snp.bottom)
            make.right.equalToSuperview().offset(-24)
            make.width.equalTo(47)
            make.height.equalTo(20)
        }
    }
    
    func setupObservers() {
        editButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.didTapEditButton.onNext(())
            })
            .disposed(by: disposeBag)
        
        selectedOrder
            .distinctUntilChanged()
            .bind(onNext: { [weak self] selectedOrder in
                guard let self = self else { return }
                self.dDayButton?.isSelected = selectedOrder == .dDay
                self.recentButton?.isSelected = selectedOrder == .recent
            })
            .disposed(by: disposeBag)
        
        selectedBrand
            .distinctUntilChanged()
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.brandList.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension MainGifticonListHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GifticonBrandListCell.self), for: indexPath)
        
        if let brandCell = cell as? GifticonBrandListCell {
            let brand = brands[indexPath.item]
            let isSelected = self.selectedBrand.value == brand
            brandCell.updateView(title: brand, isSelected: isSelected)
        }
        
        return cell
    }
}

extension MainGifticonListHeader: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBrand = brands[indexPath.item]
        
        if self.selectedBrand.value != selectedBrand {
            self.selectedBrand.accept(selectedBrand)
        }
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension MainGifticonListHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let brand = brands[indexPath.item]
        let height = GifticonBrandListCell.Dimension.height
        let size = brand.size(boundingSize: CGSize(width: Static.dimension.screenWidth, height: height), font: Static.font.body1)
        let width: CGFloat = 14 + ceil(size.width) + 14
        
        return CGSize(width: width, height: height)
    }
}
