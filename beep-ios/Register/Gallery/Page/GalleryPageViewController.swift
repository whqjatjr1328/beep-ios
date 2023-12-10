//
//  GalleryPageViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/20.
//

import UIKit
import Photos
import SnapKit
import RxSwift

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
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return fetchOption
    }()
    
    var imageManager: PHCachingImageManager?
    var selectedImageViewModel: SelectedImageViewModel?
    
    let disposeBag = DisposeBag()
    
    init(imageManager: PHCachingImageManager, selectedImageViewModel: SelectedImageViewModel) {
        self.imageManager = imageManager
        self.selectedImageViewModel = selectedImageViewModel
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
        setupObservers()
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
    
    func setupObservers() {
        selectedImageViewModel?.selectedImages
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func requestImage(asset: PHAsset) -> Single<UIImage?> {
        return Single.create { [weak self] single in
            guard let self else { return Disposables.create() }
            
            let targetSize = CGSize(width: 200, height: 200)
            let option = PHImageRequestOptions()
            option.isSynchronous = true
            self.imageManager?.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: option, resultHandler: { image, _ in
                single(.success(image))
            })
            
            return Disposables.create()
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
            let selectedIndex = selectedImageViewModel?.selectedImageIndex(assetId: asset.localIdentifier)
            photoCell.updateCell(assetId: asset.localIdentifier)
            photoCell.updateSelectedState(selectedIndex: selectedIndex)
            
            self.requestImage(asset: asset)
                .subscribe { resultImage in
                    if let resultImage {
                        photoCell.updateCellImage(assetId: asset.localIdentifier, image: resultImage)
                    }
                }
                .disposed(by: disposeBag)
        }
        
        return cell
    }
    
    
}

extension GalleryPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GalleryPagePhotoCell else { return }
        let asset = fetchResult.object(at: indexPath.item)
        
        if selectedImageViewModel?.isSelected(assetId: asset.localIdentifier) == true {
            self.selectedImageViewModel?.removeSelectedImage(assetId: asset.localIdentifier)
        } else {
            self.requestImage(asset: asset)
                .observe(on: MainScheduler.asyncInstance)
                .subscribe { [weak self] resultImage in
                    guard let self = self,
                          let selectedImageViewModel = self.selectedImageViewModel,
                          let resultImage else { return }
                    
                    selectedImageViewModel.addSelectedImage(image: resultImage, assetId: asset.localIdentifier)
                }
                .disposed(by: disposeBag)
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
