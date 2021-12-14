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
    let recents: Bool
    
    //    init(recents: Bool = false) {
    //        self.recents = recents
    //    }
    
    init(recents: Bool = false, isPresented: Binding<Bool>) {
        self.viewModel = BudgetListViewModel(isPresented: isPresented)
        self.recents = recents
    }
    
    var body: some View {
        //        ScrollView(.horizontal, showsIndicators: false) {
        if recents {
            VStack(spacing: 0) {
                ForEach(budgets.prefix(3), id:\.name) { budget in
                    Button {
                        self.selectedBudget = budget
                        viewModel.isPresented.toggle()
                    } label: {
                        if let name = budget.name,
                           let lastBudgetName = budgets.last?.name {
                            ListHistoryComponent(name: name, amountSaved: budget.amountUsed, totalAmount: budget.amountTotal) .background(RoundedRectangle(cornerRadius: 20)                                                               .foregroundColor(.customPrimary.opacity(0.1)))
                                .padding(.vertical, 4)
                        }
                    }
                }
            }
            .sheet(isPresented: $viewModel.isPresented, onDismiss: nil) {
                BudgetFormModal(title: "Edit Budget", isPresented: $viewModel.isPresented, budget: self.selectedBudget)
            }
        } else {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(budgets, id:\.name) { budget in
                        Button {
                            self.selectedBudget = budget
                            viewModel.isPresented.toggle()
                        } label: {
                            if let name = budget.name,
                               let lastBudgetName = budgets.last?.name {
                                ListHistoryComponent(name: name, amountSaved: budget.amountUsed, totalAmount: budget.amountTotal)
                                    .background(RoundedRectangle(cornerRadius: 20)
                                                    .foregroundColor(.customPrimary.opacity(0.1)))
                                    .padding(.horizontal, 4)
                            }
                        }
                    }
                    .padding(4)
                }
                .navigationTitle("Budgets")
                .navigationBarTitleDisplayMode(.inline)
            }
            
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
