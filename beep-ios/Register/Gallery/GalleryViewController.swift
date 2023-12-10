//
//  GalleryViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/17.
//

import UIKit
import Photos
import SnapKit
import RxSwift
import RxCocoa

class GalleryViewController: UIViewController {
    let topView = GalleryTopView()
    let bottomView = GalleryBottoView()
    let selectedImageView = GallerySelectedImageListView()
    let pageTabView = GalleryPageTabView()
    
    var galleryPageVC: GalleryPageViewController?
    var recommendPageVC: GalleryPageViewController?
    var pageViewController: UIPageViewController?
    
    weak var selectedImageViewModel: SelectedImageViewModel?
    
    let disposeBag = DisposeBag()
    
    init(selectedImageViewModel: SelectedImageViewModel) {
        self.selectedImageViewModel = selectedImageViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservers()
    }
    
    func setupViews() {
        guard let selectedImageViewModel else { return }
        view.backgroundColor = .white
        
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Static.dimension.safeArae.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(GalleryTopView.Dimension.height)
        }
        
        view.addSubview(selectedImageView)
        selectedImageView.frame.origin = CGPoint(x: 0, y: Static.dimension.safeArae.top + GalleryTopView.Dimension.height)
        selectedImageView.frame.size.width = Static.dimension.screenWidth
        
        view.addSubview(pageTabView)
        pageTabView.snp.makeConstraints { make in
            make.top.equalTo(selectedImageView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Static.dimension.safeArae.bottom)
            make.height.equalTo(GalleryBottoView.Dimension.height)
        }
        
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(pageTabView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        pageViewController.didMove(toParent: self)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        self.pageViewController = pageViewController
        
        let imageManager = PHCachingImageManager()
        let galleryPageVC = GalleryPageViewController(imageManager: imageManager, selectedImageViewModel: selectedImageViewModel)
        self.galleryPageVC = galleryPageVC
        let recommendPageVC = GalleryPageViewController(imageManager: imageManager, selectedImageViewModel: selectedImageViewModel)
        self.recommendPageVC = recommendPageVC
        
        pageViewController.setViewControllers([galleryPageVC], direction: .forward, animated: false)
    }
    
    func setupObservers() {
        pageTabView.selectedPage
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] pageType in
                guard let self else { return }
                let nextVC = pageType == .all ? self.galleryPageVC : self.recommendPageVC
                let navigationDirection: UIPageViewController.NavigationDirection = pageType == .all ? .forward : .reverse
                guard let vc = nextVC else { return }
                pageViewController?.setViewControllers([vc], direction: navigationDirection, animated: true)
            })
            .disposed(by: disposeBag)
        
        selectedImageViewModel?.selectedImages
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] selectedImages in
                guard let self else { return }
                self.selectedImageView.reloadSelectedImages(selectedImages: selectedImages)
                self.bottomView.selectedImageCount.accept(selectedImages.count)
            })
            .disposed(by: disposeBag)
        
        selectedImageViewModel?.selectedImages
            .map({ $0.isEmpty == false })
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] shouldShowSelectedPhotosView in
                guard let self else { return }
                self.showSelectedPhotosView(isShow: shouldShowSelectedPhotosView)
                self.topView.selectButtonEnabled.accept(shouldShowSelectedPhotosView)
            })
            .disposed(by: disposeBag)
        
        selectedImageView.removeSelectedImage
            .subscribe(onNext: { [weak self] removeIndex in
                guard let self else { return }
                self.selectedImageViewModel?.removeSelectedImage(index: removeIndex)
            })
            .disposed(by: disposeBag)
        
        topView.didSelectTopButton
            .subscribe { [weak self] topAction in
                guard let self else { return }
                switch topAction {
                case .cancel:
                    self.selectedImageViewModel?.galleryEvent.onNext(.cancelGallery)
                case .select:
                    self.selectedImageViewModel?.galleryEvent.onNext(.didFinishSelectImages)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    func showSelectedPhotosView(isShow: Bool) {
        let height: CGFloat = isShow ? GallerySelectedImageListView.Dimension.height : 0
        UIView.animate(withDuration: 0.25) {
            self.selectedImageView.frame.size.height = height
        } completion: { _ in
            self.selectedImageView.isHidden = isShow == false
        }
    }
}

extension GalleryViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}
