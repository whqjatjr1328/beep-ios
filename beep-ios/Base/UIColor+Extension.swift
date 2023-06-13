//
//  UIColor+Extension.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        var hexStr = hexString
        if hexStr.contains("#") {
            hexStr.removeAll(where: { $0 == "#" })
        }
        
        if let hex = hexStr.hex {
            self.init(hex: hex)
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    convenience init(hex: Int) {
        self.init(hex: hex, a: 1.0)
    }
    
    convenience init(hex: Int, a: CGFloat) {
        self.init(r: (hex >> 16) & 0xff, g: (hex >> 8) & 0xff, b: hex & 0xff, a: a)
    }
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(r: r, g: g, b: b, a: 1.0)
    }
    
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
}
