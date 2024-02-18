//
//  Dimension.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/07/30.
//

import UIKit

class Dimension {
    var safeArae: UIEdgeInsets {
        return UIApplication.shared.delegate?.window??.safeAreaInsets ?? .zero
    }
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var cropHanderWidth: CGFloat {
        return 20
    }
}
