//
//  GifticonMakerViewController.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/29.
//

import UIKit
import SnapKit
import RxSwift

class GifticonMakerViewController: UIViewController {
    
    let topView = GifticonMakerTopView()
    let selectedImageView = GallerySelectedImageListView()
    let previewListView = GifticonMakerPreviewList()
    let previewButton = GifticonMakerPreviewButton()
    let gradientView = UIView()
    let gifticonMakerFieldList: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: GifticonMakerPreviewButton.Dimension.maxWidth + 12, bottom: 0, right: 12)
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.minimumInteritemSpacing = 12
        
        let listView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        listView.bounces = false
        listView.register(GifticonMakerFiledListCell.self, forCellWithReuseIdentifier: String(describing: GifticonMakerFiledListCell.self))
        listView.showsHorizontalScrollIndicator = false
        return listView
    }()
    let gifticonMakerLabel = GifticonMakerLabelView()
    let gifticonMakeButton = GifticonMakeButton()
    
    var textInputView: GifticonMakerTextInputView?
    
    var previewButtonWidthConstraint: Constraint? = nil
    
    var selectedImageViewModel: SelectedImageViewModel?
    var disposeBag = DisposeBag()
    
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
            make.height.equalTo(GifticonMakerTopView.Dimension.height)
        }
        
        view.addSubview(selectedImageView)
        selectedImageView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(GallerySelectedImageListView.Dimension.height)
        }
        
        view.addSubview(previewListView)
        previewListView.snp.makeConstraints { make in
            make.top.equalTo(selectedImageView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(GIfticonMakerPreview.Dimension.size.height)
        }
        
        view.addSubview(previewButton)
        previewButton.snp.makeConstraints { make in
            make.top.equalTo(previewListView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            self.previewButtonWidthConstraint = make.width.equalTo(GifticonMakerPreviewButton.Dimension.maxWidth).constraint
            make.height.equalTo(GifticonMakerPreviewButton.Dimension.height)
        }
        
        gifticonMakerFieldList.delegate = self
        gifticonMakerFieldList.dataSource = self
        view.addSubview(gifticonMakerFieldList)
        gifticonMakerFieldList.snp.makeConstraints { make in
            make.top.bottom.equalTo(previewButton)
            make.left.equalTo(previewButton.snp.left)
            make.right.equalToSuperview()
        }
        
        let gradientSize = CGSize(width: GifticonMakerPreviewButton.Dimension.minWidth + 13, height: GifticonMakerPreviewButton.Dimension.height)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: .zero, size: gradientSize)
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [(GifticonMakerPreviewButton.Dimension.minWidth / gradientSize.width) as NSNumber]
        gradientView.layer.addSublayer(gradientLayer)
        view.addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.top.bottom.left.equalTo(gifticonMakerFieldList)
            make.width.equalTo(gradientSize.width)
        }
        
        gifticonMakerLabel.updateLabel(currentField: .preview)
        view.addSubview(gifticonMakerLabel)
        gifticonMakerLabel.snp.makeConstraints { make in
            make.top.equalTo(previewButton.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(GifticonMakerLabelView.Dimension.height)
        }
        
        view.addSubview(gifticonMakeButton)
        gifticonMakeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Static.dimension.safeArae.bottom - 12)
            make.width.equalTo(GifticonMakeButton.Dimension.size.width)
            make.height.equalTo(GifticonMakeButton.Dimension.size.height)
        }
        
        view.bringSubviewToFront(previewButton)
    }
    
    func setupObservers() {
        gifticonMakerLabel.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.showTextInputView(isShow: true)
            })
            .disposed(by: disposeBag)
    }
    
    func showTextInputView(isShow: Bool) {
        setupTextInputViewIfNeeded()
        guard let textInputView = self.textInputView else { return }
        UIView.animate(withDuration: 0.25) {
            textInputView.alpha = isShow ? 1.0 : 0.0
        } completion: { _ in
            if isShow {
                
            } else {
                textInputView.removeFromSuperview()
                self.textInputView = nil
            }
        }
    }
    
    func setupTextInputViewIfNeeded() {
        guard self.textInputView == nil else { return }
        let textInputView = GifticonMakerTextInputView(initailText: "", hasMaxinumLength: false)
        textInputView.alpha = 0.0
        textInputView.didEndTextEdit
            .take(1)
            .subscribe(onNext: { [weak self] inputText in
                guard let self else { return }
                self.gifticonMakerLabel.updateLabelText(text: inputText)
                self.showTextInputView(isShow: false)
            })
            .disposed(by: disposeBag)
        
        view.addSubview(textInputView)
        self.textInputView = textInputView
        textInputView.beginEdit()
    }
}

extension GifticonMakerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GifticonFieldType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GifticonMakerFiledListCell.self), for: indexPath)
        
        if let gifticonFieldCell = cell as? GifticonMakerFiledListCell {
            let gifticonField = GifticonFieldType.allCases[indexPath.item]
            gifticonFieldCell.updateCell(title: gifticonField.title, isSelected: false)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gifticonFieldTitle = GifticonFieldType.allCases[indexPath.item].title
        let size = gifticonFieldTitle.size(boundingSize: CGSize(width: Static.dimension.screenWidth, height: GifticonMakerPreviewButton.Dimension.height), font: Static.font.body1)
        return CGSize(width: 14 + ceil(size.width) + 14, height: GifticonMakerPreviewButton.Dimension.height)
    }
}

extension GifticonMakerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = GifticonMakerPreviewButton.Dimension.maxWidth - scrollView.contentOffset.x
        let validWidth = previewButton.validWidth(width: width)
        previewButtonWidthConstraint?.update(offset: validWidth)
    }
}
