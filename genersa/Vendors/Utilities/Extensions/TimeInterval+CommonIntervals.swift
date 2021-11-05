//
//  TimeInterval+CommonIntervals.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import Foundation

extension TimeInterval {
    static let minute: TimeInterval = 60.0
    static let hour: TimeInterval = 60.0 * minute
    static let day: TimeInterval = 24.0 * hour
    static let week: TimeInterval = 7 * day
}
