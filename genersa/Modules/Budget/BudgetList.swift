//
//  BudgetList.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct BudgetList: View {
    
    @ObservedObject private var viewModel: BudgetListViewModel
    
//    init(budgets: [Budget]) {
//        self.viewModel = BudgetListViewModel(budgets: budgets)
//    }
    
    #warning("to be removed, only for dummy testing")
    init(budgets: [DummyBudget]) {
        self.viewModel = BudgetListViewModel(budgets: budgets)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(viewModel.budgets, id:\.name) { budget in
                    if let icon = budget.icon, let name = budget.name {
                        BudgetCard(iconName: icon, name: name, amountUsed: budget.amountUsed, budgetAmount: budget.amountTotal)
                            .padding(budget.name == viewModel.budgets.last?.name ? .horizontal : .leading, 16)
                    }
                }
            }
        }
    }
}

struct DummyBudget {
    let icon: String
    let name: String
    let amountUsed: Double
    let amountTotal: Double
    var amountSaved: Double = 0
}

final class BudgetListViewModel: ObservableObject {
    
    @Published var budgets: [DummyBudget]
//    @Published var budgets: [Budget]
    
//    init(budgets: [Budget]) {
//        self.budgets = budgets
//    }
    
    #warning("to be removed, only for dummy testing")
    init(budgets: [DummyBudget]) {
        self.budgets = budgets
    }
}

struct BudgetList_Previews: PreviewProvider {
    
    static var previews: some View {
        BudgetList(budgets: [
            DummyBudget(icon: "car.fill", name: "Transport", amountUsed: 1300000, amountTotal: 2000000),
            DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 275000, amountTotal: 1700000),
            DummyBudget(icon: "house.fill", name: "Accomodation", amountUsed: 675000, amountTotal: 1850000),
        ])
        .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
