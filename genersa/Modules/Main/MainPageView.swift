//
//  MainPageView.swift
//  genersa
//
//  Created by Joanda Febrian on 09/11/21.
//

import SwiftUI

struct MainPageView: View {
    
    @EnvironmentObject var settings: TripSettings
    @ObservedObject private var viewModel: MainPageViewModel
    
    init(budgets: [DummyBudget], expenses: [DummyExpense], savingRecords: [DummySavingRecord]) {
        self.viewModel = MainPageViewModel(budgets: budgets, expenses: expenses, savingRecords: savingRecords)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Divider()
                    DailyBudgetPreview(dailyExpense: 0, dailyBudget: 100000)
                        .padding(16)
                    MainComponent(title: "Overview") {
                        Overview(budgets: viewModel.budgets, totalUsed: 1000000, totalSaved: 3000000, totalBudget: 5000000)
                    }
                    .padding(16)
                    MainComponent(title: "Budgets", buttonTitle: "New Budget") {
                        viewModel.presentingNewBudget.toggle()
                    } content: {
                        BudgetList(budgets: viewModel.budgets, isPresented: $viewModel.presentingEditBudget)
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
                            ExpensesList(expenses: Array(viewModel.expenses.prefix(3)), recents: true)
                            if viewModel.expenses.count > 3 {
                                CustomNavigationLink(
                                    title: "See More",
                                    type: .secondary,
                                    fullWidth: false,
                                    destination:
                                        ExpensesList(budgets: viewModel.budgets, expenses: viewModel.expenses, recents: false)
                                        .environmentObject(settings))
                            }
                        }
                        .sheet(isPresented: $viewModel.presentingAddExpense, onDismiss: nil) {
//                            AddExpenses(isPresented: $viewModel.presentingAddExpense)
                            NewRecord(isPresented: $viewModel.presentingAddExpense, type: .expense)
                        }
                    }
                    .padding(16)
                    MainComponent(title: "Savings", buttonTitle: "New Saving") {
                        viewModel.presentingAddSavingRecord.toggle()
                    } content: {
                        VStack(spacing: 16) {
                            SavingsList(savings: Array(viewModel.savingRecords.prefix(3)), recents: true)
                            if viewModel.savingRecords.count > 3 {
                                CustomNavigationLink(
                                    title: "See More",
                                    type: .secondary,
                                    fullWidth: false,
                                    destination:
                                        SavingsList(savings: viewModel.savingRecords).environmentObject(settings))
                            }
                        }
                        .sheet(isPresented: $viewModel.presentingAddSavingRecord, onDismiss: nil) {
//                            AddSavingRecord(isPresented: $viewModel.presentingAddSavingRecord)
                            NewRecord(isPresented: $viewModel.presentingAddSavingRecord, type: .saving)
                        }
                    }
                    .padding(16)
                }
            }
        }
    }
}

struct DummyMainPageView: View {
    var body: some View {
        MainPageView(budgets: [
                        DummyBudget(icon: "car.fill", name: "Transport", amountUsed: 1300000, amountTotal: 2000000),
                        DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 275000, amountTotal: 1700000),
                        DummyBudget(icon: "house.fill", name: "Accomodation", amountUsed: 675000, amountTotal: 1850000),
                     ],
                     expenses: [
                        DummyExpense(amount: 50000, date: Date().addingTimeInterval(-2000), notes: "McD Korea",
                                      budget: DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 1, amountTotal: 1, amountSaved: 1)),
                        DummyExpense(amount: 2000000, date: Date().addingTimeInterval(-90000), notes: "Berangkat Ke Korea",
                                      budget: DummyBudget(icon: "car.fill", name: "Transport", amountUsed: 1, amountTotal: 1, amountSaved: 1)),
                        DummyExpense(amount: 1000000, date: Date().addingTimeInterval(-100000), notes: "Capsule Hotel Korea",
                                      budget: DummyBudget(icon: "house.fill", name: "Accommodation", amountUsed: 1, amountTotal: 1, amountSaved: 1)),
                        DummyExpense(amount: 1000000, date: Date().addingTimeInterval(-100000), notes: "Capsule Hotel Korea",
                                      budget: DummyBudget(icon: "house.fill", name: "Accommodation", amountUsed: 1, amountTotal: 1, amountSaved: 1)),
                     ],
                     savingRecords: [
                        DummySavingRecord(amountSaved: 1500000, goal: 2000000, date: Date()),
                        DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 30))),
                        DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 60))),
                        DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 90))),
                     ])
            .navigationTitle("Bali 2022")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Settings")
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.customPrimary)
                    }

                }
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}

final class MainPageViewModel: ObservableObject {
    
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

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainPageView(budgets: [
                            DummyBudget(icon: "car.fill", name: "Transport", amountUsed: 1300000, amountTotal: 2000000, amountSaved: 1500000),
                            DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 275000, amountTotal: 1700000, amountSaved: 500000),
                            DummyBudget(icon: "house.fill", name: "Accomodation", amountUsed: 675000, amountTotal: 1850000, amountSaved: 800000),
                         ],
                         expenses: [
                            DummyExpense(amount: 50000, date: Date().addingTimeInterval(-2000), notes: "McD Korea",
                                          budget: DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 1, amountTotal: 1, amountSaved: 1)),
                            DummyExpense(amount: 2000000, date: Date().addingTimeInterval(-90000), notes: "Berangkat Ke Korea",
                                          budget: DummyBudget(icon: "car.fill", name: "Transport", amountUsed: 1, amountTotal: 1, amountSaved: 1)),
                            DummyExpense(amount: 1000000, date: Date().addingTimeInterval(-100000), notes: "Capsule Hotel Korea",
                                          budget: DummyBudget(icon: "house.fill", name: "Accommodation", amountUsed: 1, amountTotal: 1, amountSaved: 1)),
                            DummyExpense(amount: 1000000, date: Date().addingTimeInterval(-100000), notes: "Capsule Hotel Korea",
                                          budget: DummyBudget(icon: "house.fill", name: "Accommodation", amountUsed: 1, amountTotal: 1, amountSaved: 1)),
                         ],
                         savingRecords: [
                            DummySavingRecord(amountSaved: 1500000, goal: 2000000, date: Date()),
                            DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 30))),
                            DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 60))),
                            DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 90))),
                         ])
                .navigationTitle("Bali 2022")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Settings")
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.customPrimary)
                        }

                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
        }
    }
}
