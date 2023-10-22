//
//  GalleryViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class GalleryViewController: UIViewController {
    let topView = GalleryTopView()
    let bottomView = GalleryBottoView()
    let selectedImageView = GallerySelectedImageListView()
    let pageTabView = GalleryPageTabView()
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
        view.backgroundColor = .white
        
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Static.dimension.safeArae.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(GalleryTopView.Dimension.height)
        }
        
        view.addSubview(selectedImageView)
        selectedImageView.frame.origin = CGPoint(x: 0, y: Static.dimension.safeArae.top + GalleryTopView.Dimension.height)
        
        view.addSubview(pageTabView)
        pageTabView.snp.makeConstraints { make in
            make.top.equalTo(selectedImageView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(Static.dimension.safeArae.bottom)
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
    }
    
    func setupObservers() {
        pageTabView.selectedPage
            .subscribe()
            .disposed(by: disposeBag)
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
