//
//  Extention+String.swift
//  Summit
//
//  Created by user238596 on 10/04/24
//

import UIKit

extension String {
    func toDate(_ format: DateFormatType) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) ?? Date()
    }
}

// MARK: - Validations
extension String {
    // MARK: - isBlank
    var isBlank: Bool {
        trimmingCharacters(in: CharacterSet.whitespaces).isEmpty
    }

    // MARK: - isEmail
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                                                options: .caseInsensitive)
            return regex.firstMatch(in: self,
                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                    range: NSRange(location: 0, length: count)) != nil
        } catch {
            return false
        }
    }

    // MARK: - isPhoneNumber
    var isPhoneNumber: Bool {
        let types: NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else {
            return false
        }
        if let match = detector
            .matches(in: self, options: [], range: NSRange(location: 0, length: count))
            .first?
            .phoneNumber {
            return match == self
        } else {
            return false
        }
    }

    // MARK: - isValidPassword
    var isValidPassword: Bool {
        if count < 8 {
            return false
        }
        if range(of: #"\d+"#, options: .regularExpression) == nil {
            return false
        }
        if range(of: #"\p{Alphabetic}+"#, options: .regularExpression) == nil {
            return false
        }
        if range(of: #"\s+"#, options: .regularExpression) != nil {
            return false
        }
        return true
    }
}
