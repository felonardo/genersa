//
//  CompleteOverview.swift
//  genersa
//
//  Created by Joanda Febrian on 14/11/21.
//

import SwiftUI

struct CompleteOverview: View {
    
    @FetchRequest(
        entity: Budget.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Budget.name, ascending: true)
        ]) var budgets: FetchedResults<Budget>
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(budgets, id: \.name) { budget in
                    BudgetOverview(budget: budget)
                }
            }
            .padding(16)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Overview")
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
            CompleteOverview()
        }
    }
}
