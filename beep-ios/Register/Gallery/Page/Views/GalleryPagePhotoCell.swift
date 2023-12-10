//
//  GalleryPagePhotoCell.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/20.
//

import UIKit
import SnapKit

class GalleryPagePhotoCell: UICollectionViewCell {
    let imageView = UIImageView()
    let coverView = UIView()
    let selectedView: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = Static.color.white
        label.font = Static.font.title4
        label.layer.cornerRadius = 14
        label.layer.masksToBounds = true
        label.layer.borderWidth = 2
        return label
    }()
    
    var selectedColor: UIColor { return Static.color.beepPink }
    var unSeletedColor: UIColor { return Static.color.gray }
    
    var assetId: String = ""
    var currentImage: UIImage? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateCell(assetId: "")
        updateSelectedState(selectedIndex: nil)
    }
    
    func setupViews() {
        contentView.backgroundColor = Static.color.lightGray
        contentView.layer.masksToBounds = true
        
        imageView.backgroundColor = Static.color.gray
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        coverView.backgroundColor = Static.color.black.withAlphaComponent(0.3)
        coverView.isHidden = true
        contentView.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        updateSelectedState(selectedIndex: nil)
        contentView.addSubview(selectedView)
        selectedView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.width.height.equalTo(28)
        }
    }
    
    func updateSelectedState(selectedIndex: Int?) {
        if let selectedIndex = selectedIndex {
            contentView.layer.borderColor = Static.color.mediumPink.cgColor
            contentView.layer.borderWidth = 4
            coverView.isHidden = false
            selectedView.backgroundColor = selectedColor
            selectedView.layer.borderColor = selectedColor.cgColor
            selectedView.text = "\(selectedIndex + 1)"
        } else {
            contentView.layer.borderColor = nil
            contentView.layer.borderWidth = 0
            coverView.isHidden = true
            selectedView.backgroundColor = unSeletedColor.withAlphaComponent(0.2)
            selectedView.layer.borderColor = unSeletedColor.cgColor
            selectedView.text = ""
        }
    }
    
    func updateCell(assetId: String) {
        self.assetId = assetId
    }
    
    func updateCellImage(assetId: String, image: UIImage?) {
        if assetId == self.assetId {
            currentImage = image
            imageView.image = image
        } else {
            currentImage = nil
            imageView.image = nil
        }
    }
    
    
}
