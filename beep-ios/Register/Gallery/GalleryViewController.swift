//
//  GalleryViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/17.
//

import UIKit
import SnapKit

class GalleryViewController: UIViewController {
    let topView = GalleryTopView()
    let bottomView = GalleryBottoView()
    let selectedImageView = GallerySelectedImageListView()
    let pageTabView = GalleryPageTabView()
    
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
    }
    
    func setupObservers() {
        
    }
}
