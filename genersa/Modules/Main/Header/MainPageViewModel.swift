//
//  MainPageViewModel.swift
//  genersa
//
//  Created by Joanda Febrian on 16/11/21.
//

import SwiftUI

final class MainPageViewModel: ObservableObject {
    
    @AppStorage("tripName") var tripName: String = ""
    
    @Published var presentingNewBudget: Bool = false
    @Published var presentingEditBudget: Bool = false
    @Published var presentingAddExpense: Bool = false
    @Published var presentingAddSavingRecord: Bool = false
    @Published var budgets: [DummyBudget]
    @Published var expenses: [DummyExpense]
    @Published var savingRecords: [DummySavingRecord]
    
    init(budgets: [DummyBudget], expenses: [DummyExpense], savingRecords: [DummySavingRecord]) {
        self.budgets = budgets
        self.expenses = expenses
        self.savingRecords = savingRecords
    }
}
