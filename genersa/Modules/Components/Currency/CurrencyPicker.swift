//
//  CurrencyPicker.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct CurrencyPicker: View {
    
    @AppStorage("tripCurrency") var identifier: String = Currency.allCurrencies.first!.identifier
    
    var body: some View {
        NavigationLink {
            CurrencyList(currencySelected: $identifier)
        } label: {
            let currency = Currency.allCurrencies.first(where: {$0.identifier == identifier}) ?? Currency.allCurrencies.first!
            Text(currency.code)
                .foregroundColor(.customPrimary)
        }
        .buttonStyle(.plain)
    }
}

struct CurrencyPickerSecondary: View {
    
    @AppStorage("tripCurrency") var identifier: String = Currency.allCurrencies.first!.identifier
    
    var body: some View {
        NavigationLink {
            CurrencyList(currencySelected: $identifier)
        } label: {
            HStack{
                let currency = Currency.allCurrencies.first(where: {$0.identifier == identifier}) ?? Currency.allCurrencies.first!
                Text(currency.name)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct CurrencyPickerThird: View {
    @AppStorage("tripCurrency") var identifier: String = Currency.allCurrencies.first!.identifier
    
    var body: some View {
        NavigationLink {
            CurrencyList(currencySelected: $identifier)
        } label: {
            HStack{
                let currency = Currency.allCurrencies.first(where: {$0.identifier == identifier}) ?? Currency.allCurrencies.first!
                Text(currency.name)
                Spacer()
//                Image(systemName: "chevron.right")
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct CurrencyPickerThird_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CurrencyPickerThird()
        }
    }
}
