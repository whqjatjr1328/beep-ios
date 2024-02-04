//
//  BottomSheetView.swift
//  beep-ios
//
//  Created by BeomSeok on 2/4/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BottomSheetView: UIView {
    let sheetHeight: CGFloat
    var sheetViewOriginY: CGFloat {
        return Static.dimension.screenHeight - sheetHeight
    }
    
    let sheetHandlerView = UIView()
    
    let sheetView: UIView = {
        let view = UIView()
        view.backgroundColor = Static.color.white
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1.0
        view.layer.borderColor = Static.color.lightGray.cgColor
        return view
    }()
    
    private var isMovingSheet: Bool = false
    
    let closeSheetView = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    init(sheetHeight: CGFloat) {
        self.sheetHeight = sheetHeight
        let size = CGSize(width: Static.dimension.screenWidth, height: Static.dimension.screenHeight)
        super.init(frame: CGRect(origin: .zero, size: size))
        setupViews()
        setupObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = Static.color.black.withAlphaComponent(0.3)
        
        sheetView.frame = CGRect(x: 0, y: sheetViewOriginY, width: Static.dimension.screenWidth, height: sheetHeight)
        addSubview(sheetView)
        
        let handlerBar = UIView()
        handlerBar.backgroundColor = UIColor(hexString: "#D9D9D9")
        sheetView.addSubview(handlerBar)
        handlerBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(54)
            make.height.equalTo(3)
        }
        
        sheetView.addSubview(sheetHandlerView)
        sheetHandlerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    func setupObserver() {
        rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] gesture in
                guard let self, self.isMovingSheet == false else { return }
                
                let location = gesture.location(in: self)
                guard self.sheetView.frame.contains(location) == false else { return }
                
                self.hideSheetView()
            })
            .disposed(by: disposeBag)
        
        sheetHandlerView.rx.panGesture()
            .subscribe(onNext: { [weak self] gesture in
                guard let self else { return }
                switch gesture.state {
                case .began:
                    self.isMovingSheet = true
                case .changed:
                    guard self.isMovingSheet else { return }
                    let location = gesture.location(in: self)
                    
                    let newSheetOriginY = max(location.y, self.sheetViewOriginY)
                    self.sheetView.frame.origin.y = newSheetOriginY
                    
                case .ended, .failed, .cancelled:
                    if isMovingSheet {
                        let currentSheetY = self.sheetView.frame.origin.y
                        let distance = max(0, currentSheetY - self.sheetViewOriginY)
                        
                        if distance > self.sheetHeight / 2 {
                            self.hideSheetView()
                            
                        } else {
                            self.setSheetViewY(originY: self.sheetViewOriginY)
                        }
                    }
                    
                    self.isMovingSheet = false
                
                default:
                    return
                }
            })
            .disposed(by: disposeBag)
    }
    
    func showSheetView() {
        self.isHidden = false
        let screenHeight = Static.dimension.screenHeight
        
        self.alpha = 0.0
        self.sheetView.alpha = 0.0
        self.sheetView.frame.origin.y = screenHeight
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1.0
            self.sheetView.alpha = 1.0
            self.sheetView.frame.origin.y = self.sheetViewOriginY
        }
    }
    
    func hideSheetView() {
        UIView.animateKeyframes(withDuration: 0.25, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                self.sheetView.alpha = 0.0
                self.sheetView.frame.origin.y = Static.dimension.screenHeight
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1.0) {
                self.alpha = 0.0
            }
        } completion: { _ in
            self.isHidden = true
            self.closeSheetView.onNext(())
        }
    }
    
    func setSheetViewY(originY: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.sheetView.frame.origin.y = originY
        }
    }
}
