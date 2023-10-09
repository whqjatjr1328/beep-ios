//
//  Gifticon.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/08/15.
//

import RealmSwift

class Gifticon: Object {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var userId: String = ""
    
    @Persisted var croppedUrl: String = ""
    @Persisted var croppedRect: List<Float> = List<Float>()
    @Persisted var originUrl: String = ""
    
    @Persisted var name: String = ""
    @Persisted var brand: String = ""
    @Persisted var displayBrand: String = ""
    @Persisted var barcode: String = ""
    @Persisted var memo: String = ""
    @Persisted var isUsed: Bool = false
    
    @Persisted var isCashCard: Bool = false
    @Persisted var totalCash: Int = 0
    @Persisted var remainCash: Int = 0
    
    @Persisted var expireAt: Date = Date()
    @Persisted var udatedAt: Date = Date()
    @Persisted var createdAt: Date = Date()
}
