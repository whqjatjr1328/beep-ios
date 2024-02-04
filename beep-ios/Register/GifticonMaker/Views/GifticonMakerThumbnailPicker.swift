//
//  GifticonMakerThumbnailPicker.swift
//  beep-ios
//
//  Created by BeomSeok on 2/4/24.
//

import UIKit

enum GIfticonMakerThumbnailType: CaseIterable {
    case coffee, chicken, fastFood, convientStore, digital, movie, restaurant, sport, fashion, staionary, living, etc
    
    var title: String {
        switch self {
        case .coffee:           return "커피/베이커리"
        case .chicken:          return "치킨"
        case .fastFood:         return "패스트푸드"
        case .convientStore:    return "편의점"
        case .digital:          return "디지털"
        case .movie:            return "영화/문화"
        case .restaurant:       return "외식"
        case .sport:            return "스포치/레저"
        case .fashion:          return "패션/뷰티"
        case .staionary:        return "문구"
        case .living:           return "리빙"
        case .etc:              return "기타"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .coffee:           return UIImage(beepNamed: "asset-coffee")
        case .chicken:          return UIImage(beepNamed: "asset-chicken")
        case .fastFood:         return UIImage(beepNamed: "asset-fast-food")
        case .convientStore:    return UIImage(beepNamed: "asset-shop")
        case .digital:          return UIImage(beepNamed: "asset-digital")
        case .movie:            return UIImage(beepNamed: "asset-entertainment")
        case .restaurant:       return UIImage(beepNamed: "asset-food")
        case .sport:            return UIImage(beepNamed: "asset-sports")
        case .fashion:          return UIImage(beepNamed: "asset-fashion")
        case .staionary:        return UIImage(beepNamed: "asset-stationery")
        case .living:           return UIImage(beepNamed: "asset-living")
        case .etc:              return UIImage(beepNamed: "asset-etc")
        }
    }
}


class GifticonMakerThumbnailPicker: UIView {
    enum Dimension {
        static let size = CGSize(width: 330, height: 208)
        static let cellSize = CGSize(width: 110, height: 52)
    }
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = .zero
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = Dimension.cellSize
        
        let listView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        listView.bounces = false
        listView.showsVerticalScrollIndicator = false
        listView.register(GifticonMakerThumbnailPickerCell.self, forCellWithReuseIdentifier: String(describing: GifticonMakerThumbnailPickerCell.self))
        listView.showsHorizontalScrollIndicator = false
        return listView
        
    }()
    
    let types = GIfticonMakerThumbnailType.allCases
    
    
    init() {
        super.init(frame: CGRect(origin: .zero, size: Dimension.size))
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        collectionView.layer.cornerRadius = 8
        collectionView.layer.borderWidth = 1.0
        collectionView.layer.borderColor = Static.color.mediuimGray.cgColor
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension GifticonMakerThumbnailPicker: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GifticonMakerThumbnailPickerCell.self), for: indexPath)
        
        if let thumbnailPickerCell = cell as? GifticonMakerThumbnailPickerCell {
            let type = types[indexPath.item]
            thumbnailPickerCell.updateCell(type: type, isSelected: false)
        }
        
        return cell
    }
}
