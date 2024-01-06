//
//  GifticonMakerPreview.swift
//  beep-ios
//
//  Created by BeomSeok on 12/28/23.
//

import UIKit
import SnapKit

class GIfticonMakerPreview: UIView {
    enum Dimension {
        static let size = CGSize(width: Static.dimension.screenWidth - (GifticonMakerPreviewList.Dimension.leftInset * 2), height: 401)
    }
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView(frame: CGRect(origin: .zero, size: Dimension.size))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView(frame: CGRect(origin: .zero, size: Dimension.size))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    
    private let imageView = GifticonMakerPreviewSubviewImageView()
    private let titleView = GifticonMakerPreviewSubView(title: GifticonField.name.title)
    private let brandView = GifticonMakerPreviewSubView(title: GifticonField.brand.title)
    private let dateView = GifticonMakerPreviewSubViewDate()
    
    init() {
        super.init(frame: CGRect(origin: .zero, size: Dimension.size))
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleView)
        stackView.addArrangedSubview(brandView)
        stackView.addArrangedSubview(dateView)
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        
    }
}
