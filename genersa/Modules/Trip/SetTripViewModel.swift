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
    
//    @Published var field1 = TextBindingManager(limit: 28)
//    init(fieldTrip: String, errorState: Bool, startDate: Date, endDate: Date, isPresented: Bool, fieldBudget: String){
//        self.fieldTrip = fieldTrip
//        self.errorState = errorState
//        self.startDate = startDate
//        self.endDate = endDate
//        self.isPresented = isPresented
//        self.fieldBudget = fieldBudget
//    }
    
    func tripNameError(tripName: String) -> Bool {
        if tripName.count > 12 {
            return true
        } else {
            return false
        }
    }
    
}
