//
//  Gifticon.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/08/15.
//

import RealmSwift

class Gifticon: Object {
    @Persisted(primaryKey: true) var id = 0
    
    @Persisted var name: String = ""
    @Persisted(indexed: true) var category: String = ""
    @Persisted var thumbnailPath: String = ""
    @Persisted var dueDate: Date = Date()
}
