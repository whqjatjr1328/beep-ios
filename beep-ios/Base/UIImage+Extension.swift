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
}
