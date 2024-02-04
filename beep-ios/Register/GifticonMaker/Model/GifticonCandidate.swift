//
//  GifticonCandidate.swift
//  beep-ios
//
//  Created by BeomSeok on 1/10/24.
//

import UIKit
import RxSwift
import RxCocoa

class GifticonCandidate: NSObject {
    let originalImage: UIImage
    
    let preview: GifticonFieldString
    let thumbnail: GifticonFieldImage
    let name: GifticonFieldString
    let brand: GifticonFieldString
    let barcode: GifticonFieldString
    let expireDate: GifticonFieldDate
    let totalCash: GifticonFieldString
    
    var isCashCard: Bool = false
    
    let didUpdate = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    init(originalImage: UIImage) {
        self.originalImage = originalImage
        preview = GifticonFieldString(fieldType: .preview)
        thumbnail = GifticonFieldImage(fieldType: .thumbnail)
        name = GifticonFieldString(fieldType: .name)
        brand = GifticonFieldString(fieldType: .brand)
        barcode = GifticonFieldString(fieldType: .barcode)
        expireDate = GifticonFieldDate(fieldType: .expireDate)
        totalCash = GifticonFieldString(fieldType: .totalCash)
        
        let recognizer = GifticonTextRecogizer()
        recognizer.parse(image: originalImage)
            .subscribe(onSuccess: { text in
                print("### text \(text)")
            }, onFailure: { error in
                print("### error \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func setupObservers() {
        fields().forEach { field in
            field.didUpdateValue
                .bind(to: self.didUpdate)
                .disposed(by: self.disposeBag)
        }
    }
    
    func fields() -> [any GifticonFieldProtocol] {
        let fields: [any GifticonFieldProtocol] = [preview, thumbnail, name, brand, barcode, expireDate]
        
        if isCashCard {
            return fields + [totalCash]
        }
        
        return fields
    }
    
    func fieldsStatus() -> [GifticonFieldStatus] {
        let fields = fields().filter({ $0.fieldType != .preview })
        return fields.map { $0.fieldStatus() }
    }
    
    func isValid() -> Bool {
        return fieldsStatus().reduce(true) { $0 && $1.isValid }
    }
}
