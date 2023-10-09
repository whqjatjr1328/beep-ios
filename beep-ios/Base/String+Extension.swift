//
//  String+Extension.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import UIKit

extension String {
    var hex: Int? {
        return Int(self, radix: 16)
    }
    
    func appendingPathComponent(_ string: String) -> String {
        return (self as NSString).appendingPathComponent(string)
    }
    
    func size(boundingSize: CGSize, font: UIFont) -> CGSize {
        let boundingBox = self.boundingRect(with: boundingSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return CGSize(width: boundingBox.width, height: boundingBox.height)
    }
}
