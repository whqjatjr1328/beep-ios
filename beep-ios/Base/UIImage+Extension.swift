//
//  UIImage+Extension.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/08/15.
//

import UIKit

public extension UIImage {
    convenience init?(beepNamed: String) {
        if let bundlePath = Bundle.main.path(forResource: "Beep", ofType: "bundle") {
            self.init(named: "images/\(beepNamed)", in: Bundle(path: bundlePath), compatibleWith: nil)
            return
        }
        self.init(named: beepNamed, in: Bundle.main, compatibleWith: nil)
        
    }
    
    func calculateRect(leftX: CGFloat, topY: CGFloat, rightX: CGFloat, bottomY: CGFloat) -> CGRect {
        let minX = floor(size.width * leftX)
        let minY = floor(size.height * topY)
        
        let maxX = ceil(size.width * rightX)
        let maxY = ceil(size.height * bottomY)
        
        let width = max(0, maxX - minX)
        let height = max(0, maxY - minY)
        
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
    
    func cropImage(with rect: CGRect) -> UIImage? {
        guard let cutImageRef = self.cgImage?.cropping(to: rect) else { return nil }
        return UIImage(cgImage: cutImageRef)
    }
}
