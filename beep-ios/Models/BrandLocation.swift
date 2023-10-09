//
//  BrandLocation.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/09.
//

import RealmSwift

class BrandLocation: Object {
    @Persisted(primaryKey: true) var placeUrl: String = ""
    @Persisted var section: BrandSection
    @Persisted var adressName: String = ""
    @Persisted var placeName: String = ""
    @Persisted var categoryName: String = ""
    @Persisted var displayBrand: String = ""
    @Persisted var x: Dms?
    @Persisted var y: Dms?
}
