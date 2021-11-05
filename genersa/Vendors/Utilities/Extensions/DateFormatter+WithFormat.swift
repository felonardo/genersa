//
//  DateFormatter+ShortFormat.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import Foundation

extension DateFormatter {
    static func withFormat(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }
}
