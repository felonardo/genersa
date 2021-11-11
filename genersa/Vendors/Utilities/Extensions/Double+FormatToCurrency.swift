//
//  Double+FormatToCurrency.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import Foundation

extension Double {
    func toCurrency(_ locale: String) -> String {
        let formatter = NumberFormatter.currency(with: locale)
        return formatter.string(from: NSNumber(value: self))!
    }
}
extension String {
    func toCurrency(_ locale: String) -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter.currency(with: locale)
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
}

