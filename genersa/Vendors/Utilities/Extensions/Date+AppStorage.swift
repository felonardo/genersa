//
//  Date+AppStorage.swift
//  genersa
//
//  Created by Joanda Febrian on 16/11/21.
//

import Foundation

extension Date: RawRepresentable {
    
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}
