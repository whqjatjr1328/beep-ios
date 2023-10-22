//
//  GalleryPageViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/20.
//

import UIKit

class GalleryPageViewController: UIViewController {
    
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
    
    
}

extension GalleryPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GalleryPagePhotoCell.self), for: indexPath)
        
        if let photoCell = cell as? GalleryPagePhotoCell {
            
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
