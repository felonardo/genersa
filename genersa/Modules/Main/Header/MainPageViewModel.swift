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
    @Published var presentingSetupBudget: Bool = false
    @Published var presentingEditBudget: Bool = false
    @Published var presentingEditBudgetDetail: Bool = false
    @Published var presentingAddExpense: Bool = false
    @Published var presentingAddSavingRecord: Bool = false
    
}
