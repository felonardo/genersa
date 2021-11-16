//
//  CurrencyPicker.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct CurrencyPicker: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    var body: some View {
        NavigationLink {
            CurrencyList(currencySelected: $currency)
        } label: {
            Text(Currency.allCurrencies.first(where: {$0.identifier == currency})!.code)
                .foregroundColor(.customPrimary)
        }
        .buttonStyle(.plain)
    }
}

struct CurrencyPickerSecondary: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    var body: some View {
        NavigationLink {
            CurrencyList(currencySelected: $currency)
        } label: {
            HStack{
                Text(Currency.allCurrencies.first(where: {$0.identifier == currency})!.name)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
