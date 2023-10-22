//
//  GalleryPageInteractor.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/22.
//

import Foundation
import Photos
import RxSwift
import RxCocoa

//class GalleryPageInteractor: NSObject, PHPhotoLibraryChangeObserver {
    
//    var fetchResult: PHFetchResult<PHAsset>
//    let fetchOption: PHFetchOptions = {
//        let fetchOption = PHFetchOptions()
//        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
//        return fetchOption
//    }()
//    
//    
//    override init() {
//        fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOption)
//        super.init()
//        PHPhotoLibrary.shared().register(self)
//    }
//    
//    deinit {
//        PHPhotoLibrary.shared().unregisterChangeObserver(self)
//    }
//    
//    
//    func photoLibraryDidChange(_ changeInstance: PHChange) {
//        <#code#>
//    }
//}
