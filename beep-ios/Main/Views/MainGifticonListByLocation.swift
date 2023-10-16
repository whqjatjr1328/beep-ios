//
//  MainGifticonListByLocation.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/09.
//

import UIKit

class MainGifticonListByLocation: UICollectionViewCell {
    enum Dimension {
        static let size = CGSize(width: Static.dimension.screenWidth, height: 324)
    }
    
    var locationTitleText: String {
        return "근처에서 사용할 수 있어요"
    }
    let locationTitle: UILabel = {
        let label = UILabel()
        label.textColor = Static.color.fontDarkGray
        label.font = Static.font.title5
        return label
    }()
    
    let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(beepNamed: "Pin_fill")
        return imageView
    }()
    
    let gifticonList: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionViewLayout.minimumInteritemSpacing = 8
        collectionViewLayout.itemSize = MainGifticonByLocationCell.Dimension.size
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(MainGifticonByLocationCell.self, forCellWithReuseIdentifier: String(describing: MainGifticonByLocationCell.self))
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let mapButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Static.color.white
        button.setTitle("지도로 보러가기", for: .normal)
        button.setTitleColor(Static.color.beepPink, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = Static.color.beepPink.cgColor
        button.layer.cornerRadius = 16
        return button
    }()
    
    var gifticons: [Gifticon] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = Static.color.bg
        
        let text = locationTitleText
        let textWidth = text.size(boundingSize: CGSize(width: Static.dimension.screenWidth, height: 22), font: Static.font.title5).width
        locationTitle.text = text
        contentView.addSubview(locationTitle)
        locationTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(ceil(textWidth))
            make.height.equalTo(22)
        }
        
        contentView.addSubview(locationIcon)
        locationIcon.snp.makeConstraints { make in
            make.left.equalTo(locationTitle.snp.right).offset(4)
            make.centerY.equalTo(locationTitle)
            make.width.height.equalTo(16)
        }
        
        gifticonList.backgroundColor = .clear
        gifticonList.dataSource = self
        gifticonList.delegate = self
        contentView.addSubview(gifticonList)
        gifticonList.snp.makeConstraints { make in
            make.top.equalTo(locationTitle.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(MainGifticonByLocationCell.Dimension.size.height)
        }
        
        contentView.addSubview(mapButton)
        mapButton.snp.makeConstraints { make in
            make.top.equalTo(gifticonList.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(327)
            make.height.equalTo(54)
        }
    }
}

extension MainGifticonListByLocation: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainGifticonByLocationCell.self), for: indexPath)
        
        if let locationCell = cell as? MainGifticonByLocationCell {
            
        }
        
        return cell
    }
    
    
}

extension MainGifticonListByLocation: UICollectionViewDelegate {
    
}
