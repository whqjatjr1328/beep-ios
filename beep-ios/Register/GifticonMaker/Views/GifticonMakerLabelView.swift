//
//  GifticonMakerLabelView.swift
//  beep-ios
//
//  Created by BeomSeok on 1/7/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class GifticonMakerLabelView: UIView {
    enum Dimension {
        static let height: CGFloat = 18 + 16 + 16
    }
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Static.color.gray
        return view
    }()
    
    let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.font = Static.font.body1
        label.textColor = Static.color.gray
        label.textAlignment = .left
        return label
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = Static.font.body1
        label.textColor = Static.color.fontDarkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var countLabelWidth: CGFloat = 0
    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "0/25"
        label.font = Static.font.body1
        label.textColor = Static.color.gray
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let deletButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(beepNamed: "Close_round"), for: .normal)
        return button
    }()
    
    var labelRightConstraint: Constraint? = nil
    let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: Static.dimension.screenWidth, height: Dimension.height)))
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(placeHolderLabel)
        placeHolderLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(lineView)
        }
        
        let countLabelSize = ".00/25".size(boundingSize: CGSize(width: Static.dimension.screenWidth, height: Dimension.height),
                                          font: Static.font.body1)
        countLabelWidth = ceil(countLabelSize.width)
        addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(lineView.snp.right)
            make.width.equalTo(countLabelWidth)
            
        }
        
        addSubview(deletButton)
        deletButton.snp.makeConstraints { make in
            make.right.equalTo(lineView.snp.right)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(18)
        }
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(lineView.snp.left)
            self.labelRightConstraint = make.right.equalTo(lineView.snp.right).offset(-countLabelWidth).constraint
        }
        
        updateLabelText(text: "")
        
        setupObservers()
    }
    
    func setupObservers() {
        deletButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.updateLabelText(text: "")
            })
            .disposed(by: disposeBag)
    }
    
    func updateLabel(currentField: GifticonFieldType) {
        placeHolderLabel.text = currentField.placeHoderTitle
        countLabel.isHidden = currentField == .preview ? false : true
        deletButton.alpha = currentField == .preview ? 0.0 : 1.0
        labelRightConstraint?.update(offset: currentField == .preview ? -countLabelWidth : -18)
    }
    
    func updateLabelText(text: String) {
        label.text = text
        countLabel.text = "\(text.count)/25"
        
        let isEmptyText = text.isEmpty
        placeHolderLabel.isHidden = isEmptyText == false
        label.isHidden = isEmptyText
        deletButton.isHidden = isEmptyText
        
    }
}
