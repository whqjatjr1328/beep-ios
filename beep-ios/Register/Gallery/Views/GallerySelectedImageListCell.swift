//
//  GallerySelectedImageListCell.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/20.
//

import UIKit
import RxSwift
import RxCocoa


class GallerySelectedImageListCell: UICollectionViewCell {
    let imageView = UIImageView()
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(beepNamed: "Dell_fill"), for: .normal)
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = .clear
        
        imageView.backgroundColor = Static.color.bg
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.width.height.equalTo(48)
        }
        
        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    
    func updateCell(image: UIImage?) {
        imageView.image = image
    }
}
