//
//  Currency.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import Foundation

struct Currency {
    
    let name: String
    let code: String
    let identifier: String
    
    init(name: String, code: String, identifier: String) {
        self.name = name
        self.code = code
        self.identifier = identifier
    }
    
}

// All available currencies

extension Currency {
    
    static let allCurrencies: [Currency] = [
        Currency(name: "United States Dollar", code: "USD", identifier: "en_US"),
        Currency(name: "Euro", code: "EUR", identifier: "nl_NL"),
        Currency(name: "Japanese Yen", code: "JPY", identifier: "ja_JP"),
        Currency(name: "Pound Sterling", code: "GBP", identifier: "en_GB"),
        Currency(name: "Indonesian Rupiah", code: "IDR", identifier: "id_ID"),
    ]
    
}
