//
//  ContentView.swift
//  genersa
//
//  Created by Leo nardo on 22/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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

 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
 }
