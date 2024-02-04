//
//  BalanceParser.swift
//  beep-ios
//
//  Created by BeomSeok on 1/28/24.
//

import Foundation
import RegexBuilder

enum BalanceUnit {
    case won, thousand, tenThousand, hundThousand
    
    var value: Int {
        switch self {
        case .won:          return 1
        case .thousand:     return 1000
        case .tenThousand:  return 10000
        case .hundThousand: return 100000
        }
    }
    
    var valueString: String {
        switch self {
        case .won:          return "원"
        case .thousand:     return "천원"
        case .tenThousand:  return "만원"
        case .hundThousand: return "십만원"
        }
    }
}

struct BalanceRegexBuilder {
    let unit: BalanceUnit
    
    init(unit: BalanceUnit = .won) {
        self.unit = unit
    }
    
    func parse(string: String) -> Int? {
        
        let balanceString: String
        if unit == .won {
            let regex = Regex {
                Capture(/\d{1,3}((,\d{3})*)?/)
                unit.valueString
            }
            
            let match = try? regex.firstMatch(in: string)
            balanceString = String(match?.output.1 ?? "")
            
        } else {
            let regex = Regex {
                Capture(OneOrMore(.digit))
                unit.valueString
            }
            
            let match = try? regex.firstMatch(in: string)
            balanceString = String(match?.output.1 ?? "")
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let balance = formatter.number(from: balanceString)
        return balance?.intValue
    }
}
