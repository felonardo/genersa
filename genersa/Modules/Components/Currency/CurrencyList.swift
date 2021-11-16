//
//  CurrencyList.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct CurrencyList: View {
    
    @Binding var currencySelected: String
    let allCurrencies: [Currency] = Currency.allCurrencies
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(allCurrencies, id: \.code) { currency in
                        CurrencyListCell(currencySelected: $currencySelected,
                                         currency: currency)
                        Divider()
                    }
                }
                .padding(.top, 16)
                Spacer()
            }
        }
        .padding(.leading, 16)
        .navigationTitle("Currency")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CurrencyListCell: View {
    
    @Binding var currencySelected: String
    let currency: Currency
    
    var body: some View {
        Button {
            withAnimation {
                currencySelected = currency.identifier
            }
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(currency.name)
                    Text(currency.code)
                        .font(.caption)
                }
                Spacer()
                if currencySelected == currency.identifier {
                    Image(systemName: "checkmark")
                        .font(.title2)
                        .foregroundColor(.customPrimary)
                        .padding(.horizontal, 16)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct CurrencyListPreview: View {
    
    @State var currencySelected: String = Currency.allCurrencies.first!.identifier
    
    var body: some View {
        CurrencyList(currencySelected: $currencySelected)
    }
}

struct CurrencyList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CurrencyListPreview()
        }
    }
}
