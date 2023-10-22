//
//  GalleryPageViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/20.
//

import UIKit
import Photos
import SnapKit

class GalleryPageViewController: UIViewController, PHPhotoLibraryChangeObserver {
    
    let collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 4
        collectionViewFlowLayout.minimumInteritemSpacing = 4
        collectionViewFlowLayout.sectionInset = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(GalleryPagePhotoCell.self, forCellWithReuseIdentifier: String(describing: GalleryPagePhotoCell.self))
        return collectionView
    }()
    
    var fetchResult: PHFetchResult<PHAsset>
    let fetchOption: PHFetchOptions = {
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return fetchOption
    }()
    
    var imageManager: PHCachingImageManager?
    
    init(imageManager: PHCachingImageManager) {
        self.imageManager = imageManager
        fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOption)
        super.init(nibName: nil, bundle: nil)
        PHPhotoLibrary.shared().register(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
    }
    
    func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension GalleryPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GalleryPagePhotoCell.self), for: indexPath)
        
        if let photoCell = cell as? GalleryPagePhotoCell {
            let asset = fetchResult.object(at: indexPath.item)
            photoCell.updateCell(assetId: asset.localIdentifier)
            
            let targetSize = CGSize(width: 200, height: 200)
            imageManager?.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: .none, resultHandler: { resultImage, _ in
                if let resultImage = resultImage {
                    photoCell.updateCellImage(assetId: asset.localIdentifier, image: resultImage)
                }
            })
            
        }
        
        return cell
    }
    
    
}

extension GalleryPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? GalleryPagePhotoCell {
            cell.updateSelectedState(selectedIndex: nil)
        }
    }
}

extension GalleryPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = Static.dimension.screenWidth - 4 - 4
        let cellWidth = floor(totalWidth / 3)
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
