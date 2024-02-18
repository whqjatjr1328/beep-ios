//
//  GifticonMakerDrawView.swift
//  beep-ios
//
//  Created by BeomSeok on 2/12/24.
//

import UIKit
import RxSwift

class GifticonMakerDrawView: UIView {
    private let brushSize: CGFloat = 20.0
    private let maskColor = UIColor(hexString: "#444444").withAlphaComponent(0.3)
    
    let maskingView: UIView = UIView()
    
    var pathToErase: UIBezierPath?
    var currentPoint: CGPoint?
    
    let didDrawPath = PublishSubject<CGRect?>()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        self.backgroundColor = maskColor
        self.layer.masksToBounds = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc
    func panGestureRecognized(_ gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: self)

        switch gesture.state {
        case .began:
            pathToErase = UIBezierPath()
            pathToErase?.lineCapStyle = .round
            pathToErase?.move(to: point)
            currentPoint = point
        case .changed:
            pathToErase?.addQuadCurve(to: point, controlPoint: currentPoint!)
            currentPoint = point
            drawPath()
            setNeedsDisplay()
        case .ended, .cancelled:
            currentPoint = nil
            self.didDrawPath.onNext(pathToErase?.bounds)
        default:
            break
        }
        
    }
    
    func drawPath() {
        maskingView.frame = bounds
        UIGraphicsBeginImageContext(maskingView.frame.size)
        guard let context = UIGraphicsGetCurrentContext(), let path = pathToErase else { return }
        context.clear(maskingView.frame)
        // Draw background or any other content
        UIColor.white.setFill()
        UIRectFill(maskingView.frame)
        
        context.addPath(path.cgPath)
        context.setBlendMode(.clear)
        context.setLineCap(.round)
        context.setLineWidth(brushSize)
        context.setStrokeColor(UIColor.clear.cgColor)
        context.strokePath()
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            maskingView.layer.contents = image.cgImage
            self.mask = maskingView
        }
        
        UIGraphicsEndImageContext()
    }
}
