//
//  RegisterNavigationController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/29.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterNavigationController: UINavigationController {
    
    let viewModel = SelectedImageViewModel()
    let disposeBag = DisposeBag()
    
    init() {
        let galleryViewController = GalleryViewController(selectedImageViewModel: viewModel)
        super.init(rootViewController: galleryViewController)
        self.isNavigationBarHidden = true
        setupObservers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupObservers() {
        viewModel.galleryEvent
            .bind(onNext: { [weak self] galleryEvent in
                guard let self else { return }
                switch galleryEvent {
                case .cancelGallery:
                    self.dismiss(animated: true)
                case .didFinishSelectImages:
                    self.openGifticonMaker()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.gifticonMakerEvent
            .bind(onNext: { [weak self] gifticonMakerEvent in
                guard let self else { return }
                switch gifticonMakerEvent {
                case .didCancel: break
                case .didFinish: break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func openGifticonMaker() {
        let gifticonMakerVC = GifticonMakerViewController(selectedImageViewModel: viewModel)
        self.pushViewController(gifticonMakerVC, animated: true)
    }
    
    func closeGifiticonMaker() {
        self.popViewController(animated: true)
    }
}
