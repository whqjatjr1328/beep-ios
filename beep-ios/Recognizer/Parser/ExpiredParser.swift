//
//  ExpiredParser.swift
//  beep-ios
//
//  Created by BeomSeok on 1/28/24.
//

import Foundation
import RegexBuilder

struct DateRegexBuilder {
    let yearSplitter: String
    let monthSplitter: String
    
    func pares(str: String) -> Date? {
        let regex = Regex {
            Capture(Repeat(.digit, count: 4))
            /\s*/
            yearSplitter
            /\s*/
            Capture(OneOrMore(.digit))
            /\s*/
            monthSplitter
            /\s*/
            Capture(OneOrMore(.digit))
        }
        
        guard let firstMatch = try? regex.firstMatch(in: str)?.output,
              let year = Int(firstMatch.1),
              let month = Int(firstMatch.2), (1...12).contains(month),
              let day = Int(firstMatch.3), (1...31).contains(day)  else { return nil }
        
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
}

class ExpiredParser {
     let dateRegexBuilders: [DateRegexBuilder] = [ DateRegexBuilder(yearSplitter: "년", monthSplitter: "월"),
                                       DateRegexBuilder(yearSplitter: "-", monthSplitter: "-"),
                                       DateRegexBuilder(yearSplitter: ".", monthSplitter: ".") ]
    
    func parse(string: String) -> Date? {
        for dateRegex in dateRegexBuilders {
            if let date = dateRegex.pares(str: string) {
                return date
            }
        }
        
        return nil
    }
}
