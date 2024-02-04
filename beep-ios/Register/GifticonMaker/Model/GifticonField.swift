//
//  GifticonField.swift
//  beep-ios
//
//  Created by BeomSeok on 12/10/23.
//

import Foundation
import UIKit
import RxSwift

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
    
    var isLabelType: Bool {
        switch self {
        case .preview, .name, .brand, .barcode, .expireDate, .totalCash:
            return true
            
        case .thumbnail:
            return false
        }
    }
}

struct GifticonFieldStatus: Equatable {
    let type: GifticonFieldType
    let string: String
    let isValid: Bool
}

protocol GifticonFieldProtocol: AnyObject {
    associatedtype ValueType
    
    var fieldType: GifticonFieldType { get }
    
    var value: ValueType? { get set }
    var stringValue: String { get }
    var isValid: Bool { get }
    
    var cropRect: CGRect? { get set }
    var didUpdateValue: PublishSubject<Void> { get }
    
    func updateValue(value: ValueType?)
    func reset()
    func updateCropRect(cropRect: CGRect)
    func fieldStatus() -> GifticonFieldStatus
}

extension GifticonFieldProtocol {
    var stringValue: String {
        return ""
    }
    
    var isValid: Bool {
        return value != nil
    }
    
    func updateValue(value: ValueType?) {
        self.value = value
        didUpdateValue.onNext(())
    }
    
    func reset() {
        updateValue(value: nil)
    }
    
    func updateCropRect(cropRect: CGRect) {
        self.cropRect = cropRect
    }
    
    func fieldStatus() -> GifticonFieldStatus {
        return GifticonFieldStatus(type: fieldType, string: stringValue, isValid: isValid)
    }
}

class GifticonFieldString: GifticonFieldProtocol {
    typealias ValueType = String
    
    let fieldType: GifticonFieldType
    
    var value: String? = nil
    var stringValue: String {
        return value ?? ""
    }
    
    var cropRect: CGRect? = nil
    let didUpdateValue = RxSwift.PublishSubject<Void>()
    
    init(fieldType: GifticonFieldType) {
        self.fieldType = fieldType
    }
}

class GifticonFieldImage: GifticonFieldProtocol {
    typealias ValueType = UIImage
    
    let fieldType: GifticonFieldType
    
    var value: UIImage?
    var cropRect: CGRect?
    let didUpdateValue = RxSwift.PublishSubject<Void>()
    
    init(fieldType: GifticonFieldType) {
        self.fieldType = fieldType
    }
}

class GifticonFieldDate: GifticonFieldProtocol {
    typealias ValueType = Date
    
    let fieldType: GifticonFieldType
    
    var value: Date?
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var stringValue: String {
        if let value {
            return dateFormatter.string(from: value)
        }
        return ""
    }
    
    var cropRect: CGRect?
    let didUpdateValue = RxSwift.PublishSubject<Void>()
    
    init(fieldType: GifticonFieldType) {
        self.fieldType = fieldType
    }
}

