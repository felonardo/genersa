//
//  SetTripViewModel.swift
//  genersa
//
//  Created by Leo nardo on 10/11/21.
//

import Foundation
import SwiftUI

final class SetTripViewModel: ObservableObject {
    
    @AppStorage("tripName") var fieldTrip: String = "" {
        willSet {
            errorState = tripNameError(tripName: newValue)
        }
    }
    @AppStorage("tripStartDate") var startDate: Date = Date()
    @AppStorage("tripEndDate") var endDate: Date = Date()
    @AppStorage("totalBudget") var totalBudget: Double = 0
    @AppStorage("tripSet") var tripSet: Bool = false
    
    @Published var errorState: Bool = false
    @Published var isPresented: Bool = false
    @Published var fieldBudget: String = "0" {
        willSet {
            totalBudget = Double(fieldBudget)!
        }
    }
    
    func initBudget() {
        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: 0, amountUsed: 0, name: "Other", icon: "creditcard.fill")
        
        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal:  0, amountUsed: 0, name: "Accomodation", icon: "house.fill")

        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: 0, amountUsed: 0, name: "Flight", icon: "airplane")

        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: 0, amountUsed: 0, name: "Meal", icon: "fork.knife")
        
        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: 0, amountUsed: 0, name: "Shopping", icon: "bag.fill")

        let _ = BudgetDataSource.shared.createPersonalBudget(amountSaved: 0, amountTotal: 0, amountUsed: 0, name: "Transport", icon: "car.fill")
    }
    
    func tripNameError(tripName: String) -> Bool {
        if tripName.count > 12 {
            return true
        } else {
            return false
        }
    }
    
}
