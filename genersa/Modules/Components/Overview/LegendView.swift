//
//  LegendView.swift
//  genersa
//
//  Created by Joanda Febrian on 22/11/21.
//

import SwiftUI

struct LegendView: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    let name: String
    let amount: Double
    let color: Color
    
    init(name: String, amount: Double, color: Color) {
        self.name = name
        self.amount = amount
        self.color = color
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 4) {
            Circle()
                .frame(width: 12, height: 12)
                .padding(4)
                .foregroundColor(color)
            VStack(alignment: .leading) {
                Text(name)
                    .bold()
                Text(amount.toCurrency(currency))
                    .font(.caption)
            }
        }
    }
}

struct OverviewLegends: View {
    
    var totalUsed: Double
    var totalSaved: Double
    var totalAmount: Double
    var needToSave: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            LegendView(name: "Total Used", amount: totalUsed, color: .five)
            LegendView(name: "Total Saved", amount: totalSaved, color: .nine)
            LegendView(name: "Need to Save", amount: needToSave, color: .gray)
        }
    }
    

}
