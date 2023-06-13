//
//  Font.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import UIKit

class Font {
    var titleLarge: UIFont {
        return UIFont.systemFont(ofSize: 22, weight: .medium)
    }
    
    var titleMedium: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    var titleSmall: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
    var bodyLarge: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    var bodyMedium: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    var bodySmall: UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .regular)
    }
}
