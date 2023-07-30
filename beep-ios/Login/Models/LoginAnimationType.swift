//
//  LoginAnimationType.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/07/30.
//

import Foundation
import Lottie

enum LoginAnimationType: CaseIterable {
    case first, second, third
    
    var fileName: String {
        switch self {
        case .first:    return "lottie_anim1.json"
        case .second:   return "lottie_anim1.json"
        case .third:    return "lottie_anim1.json"
            
        }
    }
    
    var animationPath: String? {
        guard let bundlePath = Bundle.main.path(forResource: "Beep", ofType: "bundle") else { return nil }
        return bundlePath.appendingPathComponent("Lottie").appendingPathComponent(self.fileName)
    }
}

