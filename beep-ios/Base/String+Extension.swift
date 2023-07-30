//
//  String+Extension.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import Foundation

extension String {
    var hex: Int? {
        return Int(self, radix: 16)
    }
    
    func appendingPathComponent(_ string: String) -> String {
        return (self as NSString).appendingPathComponent(string)
    }
}
