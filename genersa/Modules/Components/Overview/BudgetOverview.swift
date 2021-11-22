//
//  BudgetOverview.swift
//  genersa
//
//  Created by Joanda Febrian on 22/11/21.
//

import SwiftUI

struct BudgetOverview: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    @State var isActive: Bool = false
    
    let amountUsed: Double
    let amountSaved: Double
    let budgetAmount: Double
    let budgetName: String
    
    init(budget: Budget) {
        amountUsed = budget.amountUsed
        amountSaved = budget.amountSaved
        budgetAmount = budget.amountTotal
        budgetName = budget.name!
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(budgetName)
                    .bold()
                    .foregroundColor(.three)
                Spacer()
                Button {
                    isActive.toggle()
                } label: {
                    Image(systemName: isActive ? "chevron.up" : "chevron.down")
                }
            }
            HStack(spacing: 4) {
                Text("\(amountUsed.toCurrency(currency))")
                    .foregroundColor(.three)
                Text("of")
                    .foregroundColor(.gray)
                Text("\(amountSaved.toCurrency(currency))")
                    .foregroundColor(.customPrimary)
                Spacer()
                Text("\(budgetAmount.toCurrency(currency))")
                    .foregroundColor(.gray)
            }
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.gray)
                        .frame(height: 16)
                    if amountUsed < amountSaved {
                        Capsule()
                            .fill(Color.customPrimary)
                            .frame(width: geometry.size.width * (amountSaved/budgetAmount), height: 16)
                        Capsule()
                            .fill(Color.three)
                            .frame(width: geometry.size.width * (amountUsed/budgetAmount), height: 16)
                    } else {
                        Capsule()
                            .fill(Color.three)
                            .frame(width: geometry.size.width * (amountUsed/budgetAmount), height: 16)
                        Capsule()
                            .fill(Color.customPrimary)
                            .frame(width: geometry.size.width * (amountSaved/budgetAmount), height: 16)
                    }
                }
            }
            if isActive {
                OverviewLegend(title: "Total Used", color: .three, amount: amountUsed)
                    .padding(.top, 8)
                OverviewLegend(title: "Total Saved", color: .customPrimary, amount: amountSaved)
                OverviewLegend(title: "Total Budget", color: .gray, amount: budgetAmount)
            }
        }
    }
}
