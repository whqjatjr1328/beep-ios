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
}
