//
//  AddSavingRecordViewModel.swift
//  genersa
//
//  Created by Leo nardo on 15/11/21.
//

import Foundation

final class AddSavingRecordViewModel: ObservableObject {
    
    @Published var errorState = false
    @Published var fieldNote = ""
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var selectedDate = Date()
    @Published var amount: String = "0"
    @Published var isPresented: Bool = true
    @Published var budgetSelected: Int = 0
    @Published var budgets: [DummyBudget] = [
            DummyBudget(icon: "car.fill", name: "Transport", amountUsed: 1300000, amountTotal: 2000000),
            DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 275000, amountTotal: 1700000),
            DummyBudget(icon: "house.fill", name: "Accomodation", amountUsed: 675000, amountTotal: 1850000),
            DummyBudget(icon: "house.fill", name: "Accomodation", amountUsed: 675000, amountTotal: 1850000),
            DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 275000, amountTotal: 1700000),
            DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 275000, amountTotal: 1700000),
    ]
    
}