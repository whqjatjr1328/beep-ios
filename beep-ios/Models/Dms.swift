//
//  DMS.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/09.
//

import RealmSwift

class Dms: EmbeddedObject {
    @Persisted var dd: Double = 0
    @Persisted var degree: Int = 0
    @Persisted var minute: Int = 0
    @Persisted var second: Int = 0
    
    init(degree: Int, minute: Int, second: Int) {
        self.dd = Double(degree) + Double(minute) / 60 + Double(second) / 3600
        self.degree = degree
        self.minute = minute
        self.second = second
    }
    
    init(dd: Double) {
        self.dd = dd
        
        let degreeDouble = floor(dd)
        let minuteDouble = floor((dd - degreeDouble) * 60)
        let secondDouble = floor(((dd - degreeDouble) * 60 - minuteDouble) * 60)
        
        self.degree = Int(degreeDouble)
        self.minute = Int(minuteDouble)
        self.second = Int(secondDouble)
    }
    
    func sample(dGap: Int, mGap: Int, sGap: Int) -> Dms {
        let dOffset = dGap != 0 ? degree % dGap : 0
        let mOffset = mGap != 0 ? minute % mGap : 0
        let sOffset = sGap != 0 ? second % sGap : 0
        return self + Dms(degree: -dOffset, minute: -mOffset, second: -sOffset)
    }
    
    public static func + (lhs: Dms, rhs: Dms) -> Dms {
        let sum = (lhs.degree + rhs.degree) * 3600 + (lhs.minute + rhs.minute) * 60 + (lhs.second + rhs.second)
        return Dms(dd: Double(sum))
    }
}
