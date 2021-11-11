//
//  CurrencyPicker.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct CurrencyPicker: View {
    
    @State var currencySelected: Currency
    
    init(currency: Currency) {
        self.currencySelected = currency
    }
    
    var body: some View {
        NavigationLink {
            CurrencyList(currencySelected: $currencySelected)
        } label: {
            Text(currencySelected.code)
        }
        .buttonStyle(.plain)
    }
}

struct CurrencyPickerSecondary: View {
    
    @State var currencySelected: Currency
    
    init(currency: Currency) {
        self.currencySelected = currency
    }
    
    var body: some View {
        NavigationLink {
            CurrencyList(currencySelected: $currencySelected)
        } label: {
            HStack{
                Text(currencySelected.name)
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .buttonStyle(.plain)
    }
}

struct CurrencyPicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack{
                CurrencyPicker(currency: Currency.allCurrencies.first!)
                    .navigationBarHidden(true)
                CurrencyPickerSecondary(currency: Currency.allCurrencies.first!)
            }.padding(16)
        }
    }
}
