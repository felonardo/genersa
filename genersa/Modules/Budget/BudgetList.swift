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
    
    init(isPresented: Binding<Bool>) {
        self.viewModel = BudgetListViewModel(isPresented: isPresented)
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


final class BudgetListViewModel: ObservableObject {
    
    
    @FetchRequest(
        entity: Budget.entity(),
        sortDescriptors: [
            
        ]) var budgets: FetchedResults<Budget>
    
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
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
}

struct BudgetList_Previews: PreviewProvider {
    
    static var previews: some View {
        BudgetList(isPresented: .constant(true))
    }
}
