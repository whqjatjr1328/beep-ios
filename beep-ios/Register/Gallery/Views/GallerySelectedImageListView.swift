//
//  GallerySelectedImageListView.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/17.
//

import UIKit

class GallerySelectedImageListView: UIView {
    enum Dimension {
        static let height: CGFloat = 87
    }
    
    let collectionView: UICollectionView = {
        let collectionviewFlowLayout = UICollectionViewFlowLayout()
        collectionviewFlowLayout.scrollDirection = .horizontal
        collectionviewFlowLayout.itemSize = CGSize(width: 55, height: 55)
        collectionviewFlowLayout.minimumLineSpacing = 8
        collectionviewFlowLayout.minimumInteritemSpacing = 8
        collectionviewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionviewFlowLayout)
        collectionView.register(GallerySelectedImageListCell.self, forCellWithReuseIdentifier: String(describing: GallerySelectedImageListCell.self))
        return collectionView
    }()
    
    var selectedImages: [SelectedImage] = []
    
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
            make.top.equalToSuperview().offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(55)
        }
    }
    
    func reloadSelectedImages(selectedImages: [SelectedImage]) {
        collectionView.performBatchUpdates {
            self.selectedImages = selectedImages
            self.collectionView.reloadData()
        }
    }
}

extension GallerySelectedImageListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GallerySelectedImageListCell.self), for: indexPath)
        
        if let selectedImageListCell = cell as? GallerySelectedImageListCell {
            let selectedImage = selectedImages[indexPath.item]
            selectedImageListCell.updateCell(image: selectedImage.image)
        }
        
        return cell
    }
}

extension GallerySelectedImageListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item < selectedImages.count else { return }
        let selectedImage = selectedImages[indexPath.item]
        
    }
}
