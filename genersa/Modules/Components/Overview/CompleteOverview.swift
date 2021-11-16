//
//  CompleteOverview.swift
//  genersa
//
//  Created by Joanda Febrian on 14/11/21.
//

import SwiftUI

struct CompleteOverview: View {
    
    let budgets: [DummyBudget]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(budgets, id: \.name) { budget in
                    BudgetOverview(budget: budget)
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Overview")
    }
}

struct BudgetOverview: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    @State var isActive: Bool = false
    
    let amountUsed: Double
    let amountSaved: Double
    let budgetAmount: Double
    
    init(budget: DummyBudget) {
        amountUsed = budget.amountUsed
        amountSaved = budget.amountSaved
        budgetAmount = budget.amountTotal
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Budget Name")
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

struct OverviewLegend: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    let title: String
    let color: Color
    let amount: Double
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            Text(title)
            Spacer()
            Text(amount.toCurrency(currency))
                .foregroundColor(.three)
        }
    }
    
}

struct CompleteOverview_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CompleteOverview(budgets: [
                DummyBudget(icon: "car.fill", name: "Transport", amountUsed: 1300000, amountTotal: 2000000, amountSaved: 1500000),
                DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 275000, amountTotal: 1700000, amountSaved: 500000),
                DummyBudget(icon: "house.fill", name: "Accomodation", amountUsed: 675000, amountTotal: 1850000, amountSaved: 800000),
            ])
        }
    }
}
