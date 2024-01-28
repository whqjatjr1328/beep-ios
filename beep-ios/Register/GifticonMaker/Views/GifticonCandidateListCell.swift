//
//  GifticonCandidateListCell.swift
//  beep-ios
//
//  Created by BeomSeok on 1/14/24.
//

import UIKit
import SnapKit
import RxSwift

protocol GifticonCandidateListCellDelegate: AnyObject {
    func gifticonCandidateCell(_ cell: GifticonCandidateListCell, didTapDelete: GifticonCandidate)
}

class GifticonCandidateListCell: UICollectionViewCell {
    enum Dimension {
        static let cellWidth: CGFloat = 55
        static let thumbnailWidth: CGFloat = 48
        static let deleteButtonWidth: CGFloat = 18
    }
    
    let thumbnailView = UIImageView()
    let validView: UIView = {
        let view = UIView()
        view.backgroundColor = Static.color.beepPink
        view.layer.cornerRadius = 3
        view.isHidden = true
        return view
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    weak var delegate: GifticonCandidateListCellDelegate? = nil
    weak var gifticonCandidate: GifticonCandidate? = nil
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        delegate = nil
        gifticonCandidate = nil
        validView.isHidden = true
    }
    
    func setupViews() {
        thumbnailView.layer.cornerRadius = 8
        thumbnailView.layer.borderWidth = 2
        thumbnailView.layer.borderColor = UIColor.clear.cgColor
        contentView.addSubview(thumbnailView)
        thumbnailView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.width.height.equalTo(Dimension.thumbnailWidth)
        }
        
        contentView.addSubview(validView)
        validView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.width.height.equalTo(6)
        }
        
        deleteButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self, let gifticonCandidate = self.gifticonCandidate else { return }
                self.delegate?.gifticonCandidateCell(self, didTapDelete: gifticonCandidate)
            })
            .disposed(by: disposeBag)
        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.width.height.equalTo(Dimension.deleteButtonWidth)
        }
    }
    
    func updateCell(gifticonCandidate: GifticonCandidate, isSelected: Bool) {
        self.gifticonCandidate = gifticonCandidate
        self.thumbnailView.image = gifticonCandidate.originalImage
        thumbnailView.layer.borderColor = isSelected ? Static.color.beepPink.cgColor : UIColor.clear.cgColor
        self.validView.isHidden = gifticonCandidate.isValid() == false
    }
    
}
