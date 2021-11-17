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
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    @ObservedObject private var viewModel: MainPageViewModel
    
    
    init() {
        self.viewModel = MainPageViewModel()
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Divider()
                    DailyBudgetPreview(dailyExpense: 0, dailyBudget: 100000)
                        .padding(16)
                    MainComponent(title: "Overview") {
                        Overview()
                    }
                    .padding(16)
                    MainComponent(title: "Budgets", buttonTitle: "New Budget") {
                        viewModel.presentingNewBudget.toggle()
                    } content: {
                        BudgetList(isPresented: $viewModel.presentingEditBudget)
                            .padding(.horizontal, -16)
                            .sheet(isPresented: $viewModel.presentingNewBudget, onDismiss: nil) {
                                BudgetFormModal(title: "New Budget", isPresented: $viewModel.presentingNewBudget)
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
                    MainComponent(title: "Savings", buttonTitle: "New Saving") {
                        viewModel.presentingAddSavingRecord.toggle()
                    } content: {
                        VStack(spacing: 16) {
                            SavingsList(recents: true)
                            if viewModel.savingRecords.count > 3 {
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
    var body: some View {
        MainPageView()
            .navigationTitle("Bali 2022")
            .navigationBarTitleDisplayMode(.inline)
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
