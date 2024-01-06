//
//  GifticonField.swift
//  beep-ios
//
//  Created by BeomSeok on 12/10/23.
//

import Foundation

enum GifticonFieldType: CaseIterable {
    case preview, thumbnail, name, brand, barcode, expireDate, totalCash
    
    var title: String {
        switch self {
        case .preview: ""
        case .thumbnail: "썸네일"
        case .name: "제품명"
        case .brand: "브랜드"
        case .barcode: "바코드"
        case .expireDate: "유효기간"
        case .totalCash: "남은 금액"
        }
    }
    
    var placeHoderTitle: String {
        switch self {
        case .preview: "함께 저장 할 메모를 입력해 주세요"
        case .thumbnail: "마땅한 썸네일이 없다면?"
        case .name: "제품명을 등록해 주세요."
        case .brand: "브랜드를 등록해 주세요."
        case .barcode: "바코드를 등록해 주세요."
        case .expireDate: "유효기간을 등록해 주세요."
        case .totalCash: "남은 금액을 등록해 주세요."
        }
    }
}

class GifticonField {
    let type: GifticonFieldType
    var isValid: Bool = false
    
    init(type: GifticonFieldType) {
        self.type = type
    }
}
