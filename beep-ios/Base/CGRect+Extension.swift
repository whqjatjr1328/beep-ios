//
//  CGRect+Extension.swift
//  beep-ios
//
//  Created by BeomSeok on 2/12/24.
//

import UIKit

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: width/2, y: height/2)
    }
    
    static func calculateAspectFitRect(for size: CGSize, inside targetRect: CGRect) -> CGRect {
        let targetAspectRatio = targetRect.width / targetRect.height
        let aspectRatio = size.width / size.height
        
        var resultRect = CGRect.zero
        
        if aspectRatio > targetAspectRatio {
            // Fit width-wise
            let scaledWidth = targetRect.width
            let scaledHeight = scaledWidth / aspectRatio
            let yOffset = (targetRect.height - scaledHeight) / 2.0
            resultRect = CGRect(x: targetRect.origin.x, y: targetRect.origin.y + yOffset, width: scaledWidth, height: scaledHeight)
        } else {
            // Fit height-wise
            let scaledHeight = targetRect.height
            let scaledWidth = scaledHeight * aspectRatio
            let xOffset = (targetRect.width - scaledWidth) / 2.0
            resultRect = CGRect(x: targetRect.origin.x + xOffset, y: targetRect.origin.y, width: scaledWidth, height: scaledHeight)
        }
        
        return resultRect
    }
}
