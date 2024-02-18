//
//  GifticonMakerScrollView.swift
//  beep-ios
//
//  Created by BeomSeok on 2/10/24.
//

import UIKit
import SnapKit
import RxSwift

enum GifticonMakerScrollViewMode {
    case crop, brush
    
    var title: String {
        switch self {
        case .crop: "크롭하기"
        case .brush: "문지르기"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .crop: UIImage(beepNamed: "ScrollCrop")
        case .brush: UIImage(beepNamed: "ScrollBrush")
        }
    }
    
    var swap: GifticonMakerScrollViewMode {
        switch self {
        case .crop: return .brush
        case .brush: return .crop
        }
    }
}

class GifticonMakerScrollView: UIView {
    
    let imageView = UIImageView()
    let scrollView = UIScrollView()
    var drawView: GifticonMakerDrawView?
    let scrollViewModeButton = GifticonMakerScrollViewModeButton(buttonMode: .brush)
    
    private let topMask = UIView()
    private let leftMask = UIView()
    private let rightMask = UIView()
    private let bottomMask = UIView()
    private var masks: [UIView] { return [topMask, leftMask, rightMask, bottomMask] }
    let cropView = GifticonMakerCropView()
    
    let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        
        masks.forEach { view in
            view.backgroundColor = UIColor(hexString: "#444444").withAlphaComponent(0.3)
            addSubview(view)
        }
        
        addSubview(cropView)
        
        addSubview(scrollViewModeButton)
        scrollViewModeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.right.equalToSuperview().offset(-24)
            make.size.equalTo(GifticonMakerScrollViewModeButton.Dimension.size)
        }
        
    }
    
    func setupObservers() {
        scrollViewModeButton.rx.tapGesture()
            .when(.recognized)
            .subscribe {[weak self] _ in
                guard let self else { return }
                let currentMode = self.scrollViewModeButton.buttonMode
                
                if currentMode == .brush {
                    self.showDrawView()
                    self.showCropView(isShow: false)
                } else {
                    self.removeDrawView()
                    self.showCropView(isShow: true)
                }
                
                self.scrollViewModeButton.setButtonMode(mode: currentMode.swap)
            }
            .disposed(by: disposeBag)
        
        cropView.cropEvent
            .subscribe(onNext: {[weak self] cropEvent in
                guard let self else { return }
                switch cropEvent {
                case .began:
                    break
                case .moved:
                    self.updateMasks()
                case .ended:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func showDrawView() {
        guard drawView == nil else { return }
        let drawView = GifticonMakerDrawView()
        insertSubview(drawView, belowSubview: scrollViewModeButton)
        drawView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        drawView.didDrawPath
            .take(1)
            .subscribe(onNext: {[weak self] rect in
                guard let self else { return }
                
                self.removeDrawView()
            })
            .disposed(by: disposeBag)
        
        self.drawView = drawView
    }
    
    func removeDrawView() {
        self.drawView?.removeFromSuperview()
        self.drawView = nil
    }
    
    func updateImage(image: UIImage) {
        setNeedsLayout()
        layoutIfNeeded()
        let contentSize = CGRect.calculateAspectFitRect(for: image.size, inside: self.bounds).size
        
        imageView.image = image
        imageView.frame.size = contentSize
        
        scrollView.zoomScale = 1.0
        scrollView.contentSize = contentSize
        
        updateContentViewPosition()
        
        let minContentSize = min(contentSize.width, contentSize.height)
        cropView.frame.size = CGSize(width: minContentSize, height: minContentSize)
        cropView.frame.origin = CGPoint(x: bounds.center.x - minContentSize/2, y: bounds.center.y - minContentSize/2)
        updateMasks()
    }
    
    func showCropView(isShow: Bool) {
        if isShow {
            cropView.isHidden = true
            masks.forEach({ $0.isHidden = true })
        } else {
            cropView.isHidden = false
            masks.forEach({ $0.isHidden = false })
        }
    }
    
    func updateMasks() {
        topMask.frame.origin = .zero
        topMask.frame.size = CGSize(width: bounds.width, height: cropView.frame.minY)
        
        leftMask.frame.origin = CGPoint(x: 0, y: cropView.frame.minY)
        leftMask.frame.size = CGSize(width: cropView.frame.minX, height: bounds.height - cropView.frame.minY)
        
        rightMask.frame.origin = CGPoint(x: cropView.frame.maxX, y: cropView.frame.minY)
        rightMask.frame.size = CGSize(width: bounds.width - cropView.frame.maxX, height: bounds.height - cropView.frame.minY)
        
        bottomMask.frame.origin = CGPoint(x: cropView.frame.minX, y: cropView.frame.maxY)
        bottomMask.frame.size = CGSize(width: cropView.frame.width, height: bounds.height - cropView.frame.maxY)
    }
}

extension GifticonMakerScrollView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // Calculate and update the content view's position to keep it centered
        updateContentViewPosition()
    }
    
    // Helper method to update content view's position
    private func updateContentViewPosition() {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        
        imageView.frame.origin = CGPoint(x: offsetX, y: offsetY)
    }
    
    
}
