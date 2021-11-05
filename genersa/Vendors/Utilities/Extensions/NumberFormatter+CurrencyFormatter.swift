//
//  NumberFormatter+CurrencyFormatter.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import Foundation

extension NumberFormatter {
    static func currency(with identifier: String) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: identifier)
        return formatter
    }
}
