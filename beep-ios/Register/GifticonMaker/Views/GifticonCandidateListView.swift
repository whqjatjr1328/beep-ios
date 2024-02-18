//
//  GifticonCandidateListView.swift
//  beep-ios
//
//  Created by BeomSeok on 1/14/24.
//

import UIKit
import SnapKit

class GifticonCandidateListView: UIView {
    enum Dimension {
        static let height: CGFloat = 87
    }
    
    let collectionView: UICollectionView = {
        let collectionviewFlowLayout = UICollectionViewFlowLayout()
        collectionviewFlowLayout.scrollDirection = .horizontal
        collectionviewFlowLayout.itemSize = CGSize(width: 55, height: 55)
        collectionviewFlowLayout.minimumLineSpacing = 8
        collectionviewFlowLayout.minimumInteritemSpacing = 8
        collectionviewFlowLayout.sectionInset = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionviewFlowLayout)
        collectionView.register(GifticonCandidateListCell.self, forCellWithReuseIdentifier: String(describing: GifticonCandidateListCell.self))
        return collectionView
    }()
    
    weak var viewModel: GifticonMakerViewModel?
    
    init(viewModel: GifticonMakerViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: Static.dimension.screenWidth, height: Dimension.height)))
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension GifticonCandidateListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.gifticonCandidates.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GifticonCandidateListCell.self), for: indexPath)
        
        if let candidateCell = cell as? GifticonCandidateListCell,
           let candidate = viewModel?.gifticonCandidates.value[indexPath.item] {
            let isSelected = viewModel?.selectedGifticonCandidate.value == candidate
            candidateCell.delegate = self
            candidateCell.updateCell(gifticonCandidate: candidate, isSelected: isSelected)
        }
        
        return cell
    }
}

extension GifticonCandidateListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let candidate = viewModel?.gifticonCandidates.value[indexPath.item] else { return }
        self.viewModel?.selectedGifticonCandidate.accept(candidate)
        collectionView.reloadData()
    }
}

extension GifticonCandidateListView: GifticonCandidateListCellDelegate {
    func gifticonCandidateCell(_ cell: GifticonCandidateListCell, didTapDelete: GifticonCandidate) {
        
    }
    
    
}
