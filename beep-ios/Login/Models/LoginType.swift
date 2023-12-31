//
//  LoginType.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/07/30.
//

import UIKit

enum LoginType: CaseIterable {
    case naver, kakao, google, apple, custom
    
    var bgColor: UIColor {
        switch self {
        case .naver:    return UIColor(hexString: "#03C75A")
        case .kakao:    return UIColor(hexString: "#FAE54D")
        case .google:   return UIColor(hexString: "#F6F5F5")
        case .apple:    return UIColor(hexString: "#000000")
        case .custom:   return UIColor.clear
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .naver:    return Static.color.white
        case .kakao:    return Static.color.black
        case .google:   return Static.color.black
        case .apple:    return Static.color.white
        case .custom:   return UIColor(hexString: "#AEAAAE")
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .naver:    return UIImage(beepNamed: "naver")
        case .kakao:    return UIImage(beepNamed: "kakao")
        case .google:   return UIImage(beepNamed: "google")
        case .apple:    return UIImage(beepNamed: "apple")
        case .custom:   return nil
        }
    }
    
    var title: String {
        switch self {
        case .naver:    return "네이버 로그인"
        case .kakao:    return "카카오 로그인"
        case .google:   return "Google 로그인"
        case .apple:    return "애플 로그인"
        case .custom:   return "계정 연동 없이 이용할 수 있어요"
        }
    }
}
