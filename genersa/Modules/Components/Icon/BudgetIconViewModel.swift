//
//  BudgetIconViewModel.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 14/11/21.
//

import Foundation
import SwiftUI

final class BudgetIconViewModel: ObservableObject {
    
    @Published var selectedBudget: String = "car.fill"
    @Published var budgetName: String = "" {
        willSet {
            budgetNameError = budgetNameError(budgetName: newValue)
        }
    }
    @Published var budgetNameError: Bool = false
    @Published var isPresented: Bool = false
    @Published var fieldBudget: String = "0"

    func budgetNameError(budgetName: String) -> Bool {
        if budgetName.count > 12 {
            return true
        } else {
            return false
        }
    }
    
}
