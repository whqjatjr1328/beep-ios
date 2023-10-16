//
//  Font.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import UIKit

class Font {
    var large: UIFont {
        return UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    
    var highlight1: UIFont {
        return UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    var highlight2: UIFont {
        return UIFont.systemFont(ofSize: 24, weight: .medium)
    }
    
    var title1: UIFont {
        return UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    var title2: UIFont {
        return UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    var title3: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    var title4: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    var title5: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    var body1: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    var body2: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    var body3: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
    var body4: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    var body5: UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .medium)
    }
    
    var subTitle1: UIFont {
        return UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    
    var subTitle2: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    var subText: UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .light)
    }
    
    var clip: UIFont {
        return UIFont.systemFont(ofSize: 10, weight: .medium)
    }
}
