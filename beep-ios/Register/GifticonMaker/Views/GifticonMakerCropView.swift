//
//  GifticonMakerCropView.swift
//  beep-ios
//
//  Created by BeomSeok on 2/10/24.
//

import UIKit
import SnapKit
import RxSwift

enum GifticonMakerCropEvent {
    case began, moved, ended
}

class GifticonMakerCropView: UIView {
    private var minSize: CGFloat { return Static.dimension.cropHanderWidth * 2 }
    
    let topLeft = GifticonMakerCropHandler(type: .topLeft)
    let topRight = GifticonMakerCropHandler(type: .topRight)
    let bottomLeft = GifticonMakerCropHandler(type: .bottomLeft)
    let bottomRight = GifticonMakerCropHandler(type: .bottomRight)
    
    var horizontalGrids: [UIView] = []
    var verticlaGrids: [UIView] = []
    
    private let gridCount = 2
    private var draggingHandler: GifticonMakerCropHandler? = nil
    
    private var initialPoint: CGPoint? = nil
    private var initailFrame: CGRect? = nil
    
    private var gifticonScrollView: GifticonMakerScrollView? {
        return superview as? GifticonMakerScrollView
    }
    
    let cropEvent = PublishSubject<GifticonMakerCropEvent>()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(topLeft)
        topLeft.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.height.equalTo(Static.dimension.cropHanderWidth)
        }
        
        addSubview(topRight)
        topRight.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.height.equalTo(Static.dimension.cropHanderWidth)
        }
        
        addSubview(bottomLeft)
        bottomLeft.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview()
            make.width.height.equalTo(Static.dimension.cropHanderWidth)
        }
        
        addSubview(bottomRight)
        bottomRight.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview()
            make.width.height.equalTo(Static.dimension.cropHanderWidth)
        }
        
        for _ in 0..<gridCount {
            let verticlGrid = UIView()
            verticlGrid.backgroundColor = Static.color.black.withAlphaComponent(0.3)
            verticlaGrids.append(verticlGrid)
            self.addSubview(verticlGrid)
            
            let horizontalGrid = UIView()
            horizontalGrid.backgroundColor = Static.color.black.withAlphaComponent(0.3)
            horizontalGrids.append(horizontalGrid)
            self.addSubview(horizontalGrid)
        }
        
        updateGrids()
        showGrids(isShow: false)
    }
    
    func updateGrids() {
        let bounds = self.bounds
        let verticalSpacing = bounds.width / CGFloat(gridCount + 1)
        let horizontalSpacing = bounds.height / CGFloat(gridCount + 1)
        
        verticlaGrids.enumerated().forEach { (index, verticalGrid) in
            verticalGrid.frame.origin = CGPoint(x: verticalSpacing * CGFloat(index + 1), y: 0)
            verticalGrid.frame.size = CGSize(width: 1, height: bounds.height)
        }
        
        horizontalGrids.enumerated().forEach { (index, horizontalGrid) in
            horizontalGrid.frame.origin = CGPoint(x: 0, y: horizontalSpacing * CGFloat(index + 1))
            horizontalGrid.frame.size = CGSize(width: bounds.width, height: 1)
        }
        
    }
    
    func showGrids(isShow: Bool) {
        UIView.animate(withDuration: 0.1) {
            self.updateShowGrids(isShow: isShow)
        }
    }
    
    func updateShowGrids(isShow: Bool) {
        (verticlaGrids + horizontalGrids).forEach { view in
            view.alpha = isShow ? 1.0 : 0.0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let location = touches.first?.location(in: self) else { return }
        
        if topLeft.frame.contains(location) {
            draggingHandler = topLeft
        } else if topRight.frame.contains(location) {
            draggingHandler = topRight
        } else if bottomLeft.frame.contains(location) {
            draggingHandler = bottomLeft
        } else if bottomRight.frame.contains(location) {
            draggingHandler = bottomRight
        }
        
        if draggingHandler != nil, let superview {
            initialPoint = convert(location, to: superview)
            initailFrame = frame
            updateShowGrids(isShow: true)
            cropEvent.onNext(.began)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let gifticonScrollView,
              let draggingHandler,
              let initialPoint,
              let initailFrame,
              let location = touches.first?.location(in: superview) else { return }
        
        let diffX = location.x - initialPoint.x
        let diffY = location.y - initialPoint.y
        
        var nextFrame = initailFrame
        
        switch draggingHandler.type {
        case .topLeft:
            nextFrame.origin.x += diffX
            nextFrame.size.width -= diffX
            
            nextFrame.origin.y += diffY
            nextFrame.size.height -= diffY
            
        case .topRight:
            nextFrame.size.width += diffX
            
            nextFrame.origin.y += diffY
            nextFrame.size.height -= diffY
            
        case .bottomLeft:
            nextFrame.origin.x += diffX
            nextFrame.size.width -= diffX
            
            nextFrame.size.height += diffY
            
        case .bottomRight:
            nextFrame.size.width += diffX
            
            nextFrame.size.height += diffY
        }
        
        nextFrame.origin.x = min(initailFrame.maxX - minSize, nextFrame.origin.x)
        nextFrame.size.width = max(minSize, nextFrame.size.width)
        
        nextFrame.origin.y = min(initailFrame.maxY - minSize, nextFrame.origin.y)
        nextFrame.size.height = max(minSize, nextFrame.size.height)
        
        let imageViewRect = gifticonScrollView.scrollView.convert(gifticonScrollView.imageView.frame, to: gifticonScrollView)
        
        if (draggingHandler.type == .topLeft || draggingHandler.type == .bottomLeft),
           nextFrame.minX < imageViewRect.minX {
            let adjustValue = imageViewRect.minX - nextFrame.minX
            nextFrame.origin.x = imageViewRect.minX
            nextFrame.size.width -= adjustValue
        }
        
        if (draggingHandler.type == .topRight || draggingHandler.type == .bottomRight),
           nextFrame.maxX > imageViewRect.maxX {
            let adjustValue = nextFrame.maxX - imageViewRect.maxX
            nextFrame.size.width -= adjustValue
        }
        
        if (draggingHandler.type == .topLeft || draggingHandler.type == .topRight),
           nextFrame.minY < imageViewRect.minY {
            let adjustValue = imageViewRect.minY - nextFrame.minY
            nextFrame.origin.y = imageViewRect.minY
            nextFrame.size.height -= adjustValue
        }
        
        if (draggingHandler.type == .bottomLeft || draggingHandler.type == .bottomRight),
           nextFrame.maxY > imageViewRect.maxY {
            let adjustValue = nextFrame.maxY - imageViewRect.maxY
            nextFrame.size.height -= adjustValue
        }
        
        if nextFrame.width >= minSize && nextFrame.height >= minSize {
            self.frame = nextFrame
        }
        
        updateGrids()
        
        cropEvent.onNext(.moved)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        endDragging()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        endDragging()
    }
    
    private func endDragging() {
        self.draggingHandler = nil
        self.initailFrame = nil
        self.initialPoint = nil
        
        showGrids(isShow: false)
        cropEvent.onNext(.ended)
    }
    
}
