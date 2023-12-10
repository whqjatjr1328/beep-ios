//
//  SelectedImageViewModel.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/17.
//

import Foundation
import RxSwift
import RxCocoa

class SelectedImageViewModel {
    let selectedImages = BehaviorRelay<[SelectedImage]>(value: [])
    
    let galleryEvent = PublishSubject<GalleryEvent>()
    let gifticonMakerEvent = PublishSubject<GifticonMakerEvent>()
    
    func isSelected(assetId: String) -> Bool {
        let selectedImages = self.selectedImages.value
        return selectedImages.contains(where: { $0.assetId == assetId })
    }
    
    func selectedImageIndex(assetId: String) -> Int? {
        let selectedImages = self.selectedImages.value
        return selectedImages.firstIndex(where: { $0.assetId == assetId })
    }
    
    func addSelectedImage(image: UIImage, assetId: String) {
        let newSelectedImage = SelectedImage(image: image, assetId: assetId)
        var currentSelectedImages = selectedImages.value
        currentSelectedImages.append(newSelectedImage)
        self.selectedImages.accept(currentSelectedImages)
    }
    
    func removeSelectedImage(assetId: String) {
        let currentSelectedImages = selectedImages.value
        guard let idx = currentSelectedImages.firstIndex(where: { $0.assetId == assetId }) else { return }
        removeSelectedImage(index: idx)
    }
    
    func removeSelectedImage(index: Int) {
        var currentSelectedImages = selectedImages.value
        guard index < currentSelectedImages.count else { return }
        currentSelectedImages.remove(at: index)
        self.selectedImages.accept(currentSelectedImages)
    }
    
}
