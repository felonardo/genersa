//
//  BudgetIconViewModel.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 14/11/21.
//

import Foundation
import SwiftUI

final class BudgetFormViewModel: ObservableObject {
    
    @Published var budgetIcon: String = "car.fill"
    @Published var budgetName: String = "" {
        willSet {
            budgetNameError = budgetNameError(budgetName: newValue)
        }
    }
    @Published var budgetNameError: Bool = false
    @Published var presentingCalculator: Bool = false
    @Binding var isPresented: Bool
    @Published var fieldBudget: String = "0"
    @Published var budgetId: UUID? = nil
    //    @Published var fieldPersonalBudget: String = "0"
    
    
    init(budget: Budget? = nil, isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        if let budget = budget {
            guard let icon = budget.icon, let name = budget.name, let id = budget.id else {
                fatalError()
            }
            self.budgetIcon = icon
            self.budgetName = name
            self.fieldBudget = String(budget.amountTotal)
            self.budgetId = id
        }
    }
    
    func budgetNameError(budgetName: String) -> Bool {
        if budgetName.count > 16 {
            return true
        } else {
            return false
        }
    }
    
    func initBudget(budgetName: String) {
        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: Double(fieldBudget) ?? 0, amountUsed: 0, name: budgetName, icon: "creditcard.fill")
    }
    
    func initCategorizeBudget(){
        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: Double(fieldBudget) ?? 0, amountUsed: 0, name: "Other", icon: "creditcard.fill")
        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal:  0, amountUsed: 0, name: "Accomodation", icon: "house.fill")
        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: 0, amountUsed: 0, name: "Flight", icon: "airplane")
        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: 0, amountUsed: 0, name: "Meal", icon: "fork.knife")
        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: 0, amountUsed: 0, name: "Shopping", icon: "bag.fill")
        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: 0, amountUsed: 0, name: "Transport", icon: "car.fill")
    }
    
    func createBudget(){
        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: Double(fieldBudget) ?? 0, amountUsed: 0, name: budgetName, icon: budgetIcon)
    }
    
    func editBudget(){
        let _ = BudgetDataSource.shared.updateBudget(id: budgetId!, amountTotal: Double(fieldBudget) ?? 0, name: budgetName, icon: budgetIcon)
        print("name: \(budgetName), icon: \(budgetIcon)")
    }
    
}
