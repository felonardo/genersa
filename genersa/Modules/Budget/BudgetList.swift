//
//  BudgetList.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//
import Foundation
import SwiftUI

struct BudgetList: View {
    
    @ObservedObject private var viewModel: BudgetListViewModel
    
//    init(budgets: [Budget]) {
//        self.viewModel = BudgetListViewModel(budgets: budgets)
//    }
    
    #warning("to be removed, only for dummy testing")
    init(budgets: [DummyBudget], isPresented: Binding<Bool>) {
        self.viewModel = BudgetListViewModel(budgets: budgets, isPresented: isPresented)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(viewModel.budgets, id:\.name) { budget in
                    if let icon = budget.icon, let name = budget.name {
                        Button {
                            viewModel.isPresented.toggle()
                        } label: {
                            BudgetCard(iconName: icon, name: name, amountUsed: budget.amountUsed, budgetAmount: budget.amountTotal)
                                .padding(budget.name == viewModel.budgets.last?.name ? .horizontal : .leading, 16)
                                .sheet(isPresented: $viewModel.isPresented, onDismiss: nil) {
                                    BudgetFormModal(title: "Edit Budget", isPresented: $viewModel.isPresented, budget: budget)
                                }
                        }
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
    @Binding var isPresented: Bool

//    @Published var selectedBudget: String = "car.fill"
//    @Published var budgetName: String = ""
//    @Published var budgetNameError: Bool = false
//
//    func budgetNameError(title:String) -> Bool {
//        if title.count > 12 {
//            return true
//        } else {
//            return false
//        }
//    }
    // -> pindah ke BudgetIconViewModel
//    @Published var budgets: [Budget]
    
//    init(budgets: [Budget]) {
//        self.budgets = budgets
//    }
    
    #warning("to be removed, only for dummy testing")
    init(budgets: [DummyBudget], isPresented: Binding<Bool>) {
        self.budgets = budgets
        self._isPresented = isPresented
    }
}

struct BudgetList_Previews: PreviewProvider {
    
    static var previews: some View {
        BudgetList(budgets: [
            DummyBudget(icon: "car.fill", name: "Transport", amountUsed: 1300000, amountTotal: 2000000),
            DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 275000, amountTotal: 1700000),
            DummyBudget(icon: "house.fill", name: "Accomodation", amountUsed: 675000, amountTotal: 1850000),
        ], isPresented: .constant(true))
        .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
