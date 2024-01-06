//
//  GifticonField.swift
//  beep-ios
//
//  Created by BeomSeok on 12/10/23.
//

import Foundation

enum GifticonField: CaseIterable {
    case thumbnail, name, brand, memo, barcode, expireDate, totalCash
    
    var title: String {
        switch self {
        case .thumbnail: "썸네일"
        case .name: "제품명"
        case .brand: "브랜드"
        case .memo: "메모"
        case .barcode: "바코드"
        case .expireDate: "만료일"
        case .totalCash: "남은 금액"
        }
    }
}
