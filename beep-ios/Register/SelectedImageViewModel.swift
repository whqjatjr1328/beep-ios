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
        var currentSelectedImages = selectedImages.value
        currentSelectedImages.removeAll(where: { $0.assetId == assetId })
        self.selectedImages.accept(currentSelectedImages)
    }
    
}
