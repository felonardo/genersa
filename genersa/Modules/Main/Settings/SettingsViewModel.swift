//
//  SettingsViewModel.swift
//  genersa
//
//  Created by Leo nardo on 10/11/21.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var fieldTrip: String = ""
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var errorState: Bool = false
//    @Published var currency: Currency = Currency.allCurrencies.first!
//    @Published var profileName: String = ""
//    @Published var avatar: String = ""
}
