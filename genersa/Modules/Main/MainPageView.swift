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
                                                    if budgets.count != 0 {
                                                        viewModel.presentingNewBudget.toggle()
                                                        
                                                    } else {
                                                        viewModel.presentingSetupBudget.toggle()

                                                    }
                        
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
                                            BudgetList(recents: false, isPresented: $viewModel.presentingEditBudgetDetail))
                                }
                            } else {
                                EmptyStateCardView(image: "SetupBudget_ES", width: 125, height: 171, headlineText: "Set Up Your Budget ", bodyText: "Your set budget will act as your saving goal and expense limit.", btnTitle: "Set Budget"){
                                    CustomButton(title: "Set Budget", type: .primary, fullWidth: true) {
                                        viewModel.presentingSetupBudget.toggle()
                                    }
                                }
                                
                            }
                        }
                        .sheet(isPresented: $viewModel.presentingSetupBudget, onDismiss: nil) {
                                SetupBudgetFormModal(isPresented: $viewModel.presentingSetupBudget)
                        }
                        .sheet(isPresented: $viewModel.presentingNewBudget, onDismiss: nil) {
                                BudgetFormModal(title: "New Budget", isPresented: $viewModel.presentingNewBudget)
                        }
                    }
                    .padding(16)
//                    .onAppear{
//                        
//                    }
//                    
                    
                    MainComponent(title: "Savings", buttonTitle: "New Saving") {
                        viewModel.presentingAddSavingRecord.toggle()
                    } content: {
                        VStack(spacing: 16) {
                            
                            if savingRecords.count != 0 {
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
                            } else {
                                EmptyStateCardView(image: "TrackSavings_ES", width: 125, height: 171, headlineText: "Track Your Savings", bodyText: "Keep track of how much you've saved for your travel budget.", btnTitle: "Input New Saving"){
                                    CustomButton(title: "Set Saving Plan", type: .primary, fullWidth: true) {
                                        viewModel.presentingAddSavingRecord.toggle()
                                    }
                                }
                            }
                        }
                        .sheet(isPresented: $viewModel.presentingAddSavingRecord, onDismiss: nil) {
                            if savingRecords.count != 0 {
                                NewRecord(isPresented: $viewModel.presentingAddSavingRecord, type: .saving)
                            } else {
                                SetupSavingFormModal(isPresented: $viewModel.presentingAddSavingRecord, headline: "How long do you want to save?")
                            }
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
                                EmptyStateCardView(image: "TrackExpense_ES", width: 125, height: 171, headlineText: "Track Your Expenses", bodyText: "Say goodbye to overspending by tracking your travel expenses.", btnTitle: "Input New Expense"){
                                    CustomButton(title: "Input New Expense", type: .primary, fullWidth: true) {
                                        viewModel.presentingAddExpense.toggle()
                                    }
                                }
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
