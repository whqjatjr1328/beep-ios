//
//  LoginType.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/17.
//

import UIKit

enum LoginType {
    case naver, kakao, google, apple
    
    var name: String {
        switch self {
        case .naver:    return "네이버"
        case .kakao:    return "카카오"
        case .google:   return "Google"
        case .apple:    return "Apple"
        }
    }
    
    var title: String {
        return "\(name) 계정으로 로그인"
    }
    
    var iconImage: UIImage {
        return UIImage()
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .naver:    return UIColor(hexString: "#03C75A")
        case .kakao:    return UIColor(hexString: "#FAE54D")
        case .google:   return UIColor(hexString: "#EEEEEE")
        case .apple:    return UIColor(hexString: "#000000")
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .naver, .apple:    return Static.color.whilte
        case .kakao, .google:   return Static.color.black
        }
    }
}
