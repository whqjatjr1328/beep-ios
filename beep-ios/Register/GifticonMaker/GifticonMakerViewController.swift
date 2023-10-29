//
//  GifticonMakerViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/29.
//

import UIKit

class GifticonMakerViewController: UIViewController {
    
    let topView = GifticonMakerTopView()
    let selectedImageView = GallerySelectedImageListView()
    
    
    weak var selectedImageViewModel: SelectedImageViewModel?
    
    init(selectedImageViewModel: SelectedImageViewModel) {
        self.selectedImageViewModel = selectedImageViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
