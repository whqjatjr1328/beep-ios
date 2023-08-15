//
//  PermissionType.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/08/15.
//

import UIKit

enum PermissionType: CaseIterable {
    case alarm, gallery, location
    
    var title: String {
        switch self {
        case .alarm:    return "알림"
        case .gallery:  return "사진"
        case .location: return "위치"
        }
    }
    
    var description: String {
        switch self {
        case .alarm:    return "알림 메세지 발송"
        case .gallery:  return "쿠폰 이미지 첨부"
        case .location: return "위치기반 서비스 이용"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .alarm:    return UIImage(beepNamed: "Bell_fill")
        case .gallery:  return UIImage(beepNamed: "Img_box_fill")
        case .location: return UIImage(beepNamed: "Pin_fill")
        }
    }
}
