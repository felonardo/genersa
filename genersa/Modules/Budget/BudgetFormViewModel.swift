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
//    @Published var finalvalue: String
    
    init(budget: Budget? = nil, isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        if let budget = budget {
            guard let icon = budget.icon, let name = budget.name else {
                fatalError()
            }
            self.budgetIcon = icon
            self.budgetName = name
        }
    }

    func budgetNameError(budgetName: String) -> Bool {
        if budgetName.count > 16 {
            return true
        } else {
            return false
        }
    }
    
        func createBudget(){
//            BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: Double(fieldBudget) ?? 0, amountUsed: 0, name: budgetName, icon: budgetIcon)
//            print("name: \(budgetName), icon: \(budgetIcon)")
        }

}
