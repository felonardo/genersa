//
//  MainPageView.swift
//  genersa
//
//  Created by Joanda Febrian on 09/11/21.
//

import SwiftUI

struct MainPageView: View {
    
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
                        Overview(totalUsed: 1000000, totalSaved: 3000000, totalBudget: 5000000)
                    }
                    .padding(16)
                    MainComponent(title: "Budgets", buttonTitle: "+ New Budget") {
                        print("New Budget")
                    } content: {
                        BudgetList(budgets: [
                            DummyBudget(icon: "car.fill", name: "Transport", amountUsed: 1300000, amountTotal: 2000000),
                            DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 275000, amountTotal: 1700000),
                            DummyBudget(icon: "house.fill", name: "Accomodation", amountUsed: 675000, amountTotal: 1850000),
                        ])
                        .padding(.horizontal, -16)
                    }
                    .padding(16)
                    MainComponent(title: "Savings", buttonTitle: "+ New Savings") {
                        print("New Savings")
                    } content: {
                        SavingsList(savings: [
                            DummySavingRecord(amountSaved: 1500000, goal: 2000000, date: Date()),
                            DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 30))),
                            DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 60))),
                        ])
                    }
                    .padding(16)
                }
            }
        }
    }
}

final class MainPageViewModel: ObservableObject {
    
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainPageView()
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
