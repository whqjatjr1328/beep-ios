//
//  UsageHistory.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/09.
//

import RealmSwift

class UsageHistory: Object {
    @Persisted var id: Int = 0
    @Persisted var gifticonId: Int = 0
    @Persisted var date = Date()
    @Persisted var x: Dms?
    @Persisted var y: Dms?
    @Persisted var amount: Int = 0
}
