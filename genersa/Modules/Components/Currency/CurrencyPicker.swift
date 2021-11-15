//
//  CurrencyPicker.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct CurrencyPicker: View {
    
    @EnvironmentObject var settings: TripSettings
    
    var body: some View {
        NavigationLink {
            CurrencyList(currencySelected: $settings.currency)
        } label: {
            Text(settings.currency.code)
                .foregroundColor(.customPrimary)
        }
        .buttonStyle(.plain)
    }
}

struct CurrencyPickerSecondary: View {
    
    @EnvironmentObject var settings: TripSettings
    
    var body: some View {
        NavigationLink {
            CurrencyList(currencySelected: $settings.currency)
        } label: {
            HStack{
                Text(settings.currency.name)
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .buttonStyle(.plain)
    }
}
