//
//  BrandSection.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/09.
//

import RealmSwift

class BrandSection: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var brand: String = ""
    @Persisted var x: Dms?
    @Persisted var y: Dms?
    @Persisted var searchDate = Date()
}
