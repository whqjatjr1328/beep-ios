//
//  GifticonMakerPreviewList.swift
//  beep-ios
//
//  Created by BeomSeok on 1/6/24.
//

import UIKit

class GifticonMakerPreviewList: UIView {
    enum Dimension {
        static let leftInset: CGFloat = 24
    }
    
    let collectionView: UICollectionView = {
        let collectionviewFlowLayout = UICollectionViewFlowLayout()
        collectionviewFlowLayout.scrollDirection = .horizontal
        collectionviewFlowLayout.itemSize = GIfticonMakerPreview.Dimension.size
        collectionviewFlowLayout.minimumLineSpacing = Dimension.leftInset * 2
        collectionviewFlowLayout.minimumInteritemSpacing = Dimension.leftInset * 2
        collectionviewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: Dimension.leftInset, bottom: 0, right: Dimension.leftInset)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionviewFlowLayout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GifticonMakerPreviewCell.self, forCellWithReuseIdentifier: String(describing: GifticonMakerPreviewCell.self))
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension GifticonMakerPreviewList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GifticonMakerPreviewCell.self), for: indexPath)
        
        if let selectedImageListCell = cell as? GifticonMakerPreviewCell {
        }
        
        return cell
    }
}

extension GifticonMakerPreviewList: UICollectionViewDelegate {
    
}
