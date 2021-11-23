//
//  BudgetList.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//
import Foundation
import SwiftUI

struct BudgetList: View {
    
    @FetchRequest(
        entity: Budget.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Budget.name, ascending: true)
        ]) var budgets: FetchedResults<Budget>
    
    @ObservedObject private var viewModel: BudgetListViewModel
    
    @State var selectedBudget: Budget?
    
    init(isPresented: Binding<Bool>) {
        self.viewModel = BudgetListViewModel(isPresented: isPresented)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(budgets, id:\.name) { budget in
                    Button {
                        self.selectedBudget = budget
                        viewModel.isPresented.toggle()
                    } label: {
                        if let icon = budget.icon,
                           let name = budget.name,
                           let lastBudgetName = budgets.last?.name {
                            BudgetCard(iconName: icon, name: name, amountUsed: budget.amountUsed, budgetAmount: budget.amountTotal)
                                .padding(name == lastBudgetName ? .horizontal : .leading, 16)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isPresented, onDismiss: nil) {
            BudgetFormModal(title: "Edit Budget", isPresented: $viewModel.isPresented, budget: self.selectedBudget)
        }
    }
}


final class BudgetListViewModel: ObservableObject {
    
    @Binding var isPresented: Bool
    
    
    func createBudget(amountTotal: Double, name: String, icon: String){
        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: amountTotal, amountUsed: 0, name: name, icon: icon)
    }
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
}

struct BudgetList_Previews: PreviewProvider {
    
    static var previews: some View {
        BudgetList(isPresented: .constant(true))
    }
}
