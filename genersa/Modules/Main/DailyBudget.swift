//
//  DailyBudget.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct DailyBudget: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    @Binding var dailyExpense: Double
    @Binding var dailyBudget: Double
    
    var body: some View {
        VStack(alignment: .center) {
            Text(dailyExpense.toCurrency(currency))
                .font(.largeTitle)
                .foregroundColor(.three)
                .bold()
            Text("Daily Remaining of \(dailyBudget.toCurrency(currency))")
                .font(.caption)
                .foregroundColor(.four.opacity(0.5))
        }
    }
    
}

struct DailyBudgetPreview: View {
    
    @State var dailyExpense: Double
    @State var dailyBudget: Double
    
    var body: some View {
        DailyBudget(dailyExpense: $dailyExpense, dailyBudget: $dailyBudget)
    }
}

struct DailyBudget_Previews: PreviewProvider {
    static var previews: some View {
        DailyBudgetPreview(dailyExpense: 0, dailyBudget: 100000)
    }
}
