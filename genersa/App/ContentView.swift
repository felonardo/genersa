//
//  ContentView.swift
//  genersa
//
//  Created by Leo nardo on 22/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        NavigationView {
            ScrollView {
                VStack {
                    HeaderView(tripName: "Bali 2021", tripStartDate: Date(), tripEndDate: Date().addingTimeInterval(7 * .day))
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
                }
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
        .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
 }
