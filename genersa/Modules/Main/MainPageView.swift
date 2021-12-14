//
//  MainPageView.swift
//  genersa
//
//  Created by Joanda Febrian on 09/11/21.
//

import SwiftUI

struct MainPageView: View {
    
    @FetchRequest(
        entity: Expense.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Expense.date, ascending: false)
        ]) var expenses: FetchedResults<Expense>
    
    @FetchRequest(
        entity: Budget.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Budget.name, ascending: true)
        ]) var budgets: FetchedResults<Budget>
    
    
    @FetchRequest(
        entity: SavingRecord.entity(),
        sortDescriptors: [
            
        ]) var savingRecords: FetchedResults<SavingRecord>
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    @ObservedObject private var viewModel: MainPageViewModel
    
    
    init() {
        self.viewModel = MainPageViewModel()
    }
    
    var body: some View {
        //        if tripSet {
        VStack {
            ScrollView {
                VStack {
                    Divider()
                    MainComponent(title: "Overview") {
                        Overview()
                    }
                    .padding(16)
                    MainComponent(title: "Budgets", buttonTitle: "New Budget") {
                        viewModel.presentingNewBudget.toggle()
                    } content: {
                        VStack(spacing: 16) {
                            if budgets.count != 0 {
                                BudgetList(recents: true, isPresented: $viewModel.presentingEditBudget)
                                if budgets.count > 3 {
                                    CustomNavigationLink(
                                        title: "See More",
                                        type: .secondary,
                                        fullWidth: false,
                                        destination:
                                            BudgetList(recents: false, isPresented: $viewModel.presentingEditBudget))
                                }
                            } else {
                                Image("EmptyState")
                                Text("No Budget Yet \n Your Future Expense will return here").multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $viewModel.presentingNewBudget, onDismiss: nil) {
                            BudgetFormModal(title: "New Budget", isPresented: $viewModel.presentingNewBudget)
                        }
                    }
                    .padding(16)

                    MainComponent(title: "Savings", buttonTitle: "New Saving") {
                        viewModel.presentingAddSavingRecord.toggle()
                    } content: {
                        VStack(spacing: 16) {
                            SavingsList(recents: true)
                                .background(RoundedRectangle(cornerRadius: 20)
                                                .foregroundColor(.customPrimary.opacity(0.1)))
                            if savingRecords.count > 3 {
                                CustomNavigationLink(
                                    title: "See More",
                                    type: .secondary,
                                    fullWidth: false,
                                    destination:
                                        SavingsList())
                            }
                        }
                        .sheet(isPresented: $viewModel.presentingAddSavingRecord, onDismiss: nil) {
                            NewRecord(isPresented: $viewModel.presentingAddSavingRecord, type: .saving)
                        }
                    }
                    .padding(16)
                    
                    MainComponent(title: "Expenses", buttonTitle: "New Expense") {
                        viewModel.presentingAddExpense.toggle()
                    } content: {
                        VStack(spacing: 16) {
                            if expenses.count != 0 {
                                ExpensesList(recents: true)
                                if expenses.count > 3 {
                                    CustomNavigationLink(
                                        title: "See More",
                                        type: .secondary,
                                        fullWidth: false,
                                        destination:
                                            ExpensesList(recents: false))
                                }
                            } else {
                                Image("EmptyState")
                                Text("No Expense Yet \n Your Future Expense will return here").multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $viewModel.presentingAddExpense, onDismiss: nil) {
                            NewRecord(isPresented: $viewModel.presentingAddExpense, type: .expense)
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle(viewModel.tripName)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.customPrimary)
                    }
                    
                }
            }
        }
    }
}

struct DummyMainPageView: View {
    
    @AppStorage("tripSet") var tripSet: Bool = false
    
    var body: some View {
        
        if tripSet {
            MainPageView()
                .navigationTitle("Bali 2022")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainPageView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
