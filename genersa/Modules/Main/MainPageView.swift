//
//  MainPageView.swift
//  genersa
//
//  Created by Joanda Febrian on 09/11/21.
//

import SwiftUI

struct MainPageView: View {
    
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
                        Overview(totalUsed: 1000000, totalSaved: 3000000, totalBudget: 5000000)
                    }
                    .padding(16)
                    MainComponent(title: "Budgets", buttonTitle: "New Budget") {
                        print("New Budget")
                    } content: {
                        BudgetList(budgets: viewModel.budgets)
                            .padding(.horizontal, -16)
                    }
                    .padding(16)
                    MainComponent(title: "Expenses", buttonTitle: "New Expense") {
                        VStack {
                            ExpensesList(expenses: viewModel.expenses, recents: true)
                        }
                    }
                    .padding(16)
                    MainComponent(title: "Savings", buttonTitle: "New Saving") {
                        print("New Savings")
                    } content: {
                        SavingsList(savings: viewModel.savingRecords)
                    }
                    .padding(16)
                }
            }
        }
    }
}

final class MainPageViewModel: ObservableObject {
    
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
                         ],
                         savingRecords: [
                            DummySavingRecord(amountSaved: 1500000, goal: 2000000, date: Date()),
                            DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 30))),
                            DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 60))),
                         ])
                .navigationTitle("Bali 2022")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Settings")
                        } label: {
                            Image(systemName: "gear")
                                .foregroundColor(.gray)
                        }

                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
        }
    }
}
