//
//  SetTripViewModel.swift
//  genersa
//
//  Created by Leo nardo on 10/11/21.
//

import Foundation

final class SetTripViewModel: ObservableObject {
    
    @Published var errorState: Bool = false
    @Published var fieldTrip: String = "" {
        willSet {
            errorState = tripNameError(tripName: newValue)
        }
    }
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var isPresented: Bool = false
    @Published var fieldBudget: String = "0"
    
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
