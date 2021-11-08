//
//  MainComponent.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct MainComponent<Content: View>: View {
    
    let title: String
    let buttonTitle: String?
    let action: (() -> Void)?
    let content: Content
    
    init(title: String, buttonTitle: String? = nil, action: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(.secondary)
                    .bold()
                Spacer()
                if let buttonTitle = buttonTitle {
                    Text(buttonTitle)
                        .font(.callout)
                }
            }
            content
        }
    }
}

struct MainComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MainComponent(title: "Overview") {
                Overview(totalUsed: 1000000, totalSaved: 3000000, totalBudget: 5000000)
            }
            .padding(16)
            MainComponent(title: "Budgets", buttonTitle: "+ New Budget") {
                print("New Budget")
            } content: {
                BudgetList(budgets: [
                    DummyBudget(icon: "car", name: "Transport", amountUsed: 1300000, amountTotal: 2000000),
                    DummyBudget(icon: "car", name: "Transport", amountUsed: 1300000, amountTotal: 2000000),
                    DummyBudget(icon: "car", name: "Transport", amountUsed: 1300000, amountTotal: 2000000),
                    DummyBudget(icon: "car", name: "Transport", amountUsed: 1300000, amountTotal: 2000000),
                ])
                .padding(.horizontal, -16)
            }
            .padding(16)
        }
        .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
