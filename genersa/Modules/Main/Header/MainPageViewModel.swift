//
//  MainPageViewModel.swift
//  genersa
//
//  Created by Joanda Febrian on 16/11/21.
//

import SwiftUI

final class MainPageViewModel: ObservableObject {
    
    @FetchRequest(
        entity: Budget.entity(),
        sortDescriptors: [
            
        ]) var budgets: FetchedResults<Budget>
    
    @FetchRequest(
        entity: Expense.entity(),
        sortDescriptors: [
            
        ]) var expenses: FetchedResults<Expense>
    
    
    @FetchRequest(
        entity: Expense.entity(),
        sortDescriptors: [

        ]) var savingRecords: FetchedResults<SavingRecord>
    
    @AppStorage("tripName") var tripName: String = ""
    
    @Published var presentingNewBudget: Bool = false
    @Published var presentingEditBudget: Bool = false
    @Published var presentingAddExpense: Bool = false
    @Published var presentingAddSavingRecord: Bool = false
    
}
