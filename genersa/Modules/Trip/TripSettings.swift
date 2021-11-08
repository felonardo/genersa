//
//  TripSettings.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import Foundation

final class TripSettings: ObservableObject {
    
    @Published var currency: Currency
    
    var locale: String {
        return currency.identifier
    }
    
    init(currency: Currency) {
        self.currency = currency
    }
    
}
