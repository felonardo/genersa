//
//  ExpensesList.swift
//  genersa
//
//  Created by Joanda Febrian on 14/11/21.
//

import SwiftUI

struct ExpensesList: View {
    
    let budgets: [DummyBudget]
    let expenses: [DummyExpense]
    let recents: Bool
    
    @State var selectedBudget: String = ""
    
    init(budgets: [DummyBudget] = [], expenses: [DummyExpense] = [], recents: Bool = false) {
        self.budgets = budgets
        self.expenses = expenses
        self.recents = recents
    }
    
    var mappedExpenses: [Date:[DummyExpense]] {
        var groupedExpenses = [Date:[DummyExpense]]()
        for expense in expenses {
            if groupedExpenses[expense.date.dateOnly()] != nil {
                groupedExpenses[expense.date.dateOnly()]!.append(expense)
            } else {
                groupedExpenses[expense.date.dateOnly()] = [expense]
            }
        }
        return groupedExpenses
    }
    
    var body: some View {
        if recents {
            VStack {
                ForEach(expenses, id: \.id) { expense in
                    ExpensesCell(expense: expense)
                }
            }
        } else {
            ScrollView {
                LazyVStack {
                    BudgetSlider(selectedBudget: $selectedBudget, budgets: budgets)
                    ForEach(mappedExpenses.sorted(by: {$0.key > $1.key}), id: \.key) { key, value in
                        let filteredValue = value.filter { $0.budget.name.contains(selectedBudget) || selectedBudget == "" }
                        if !filteredValue.isEmpty {
                            ExpensesListDayComponent(
                                date: key,
                                expenses: filteredValue)
                                .padding(16)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Expenses")
        }
    }
}

struct ExpensesListDayComponent: View {
    
    let date: Date
    let expenses: [DummyExpense]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(date.toString(withFormat: "d MMMM"))
                .bold()
            ForEach(expenses, id: \.id) { expense in
                ExpensesCell(expense: expense)
            }
        }
    }
}

struct ExpensesCell: View {
    
    @EnvironmentObject var settings: TripSettings
    
    let expense: DummyExpense
    
    var body: some View {
        HStack {
            Image(systemName: expense.budget.icon)
                .padding(12)
            VStack(spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(expense.budget.name)
                            .bold()
                        HStack(spacing: 4) {
                            Text(expense.date.toString(withFormat: "HH.mm"))
                            Text(expense.notes)
                        }
                        .font(.caption)
                        .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(expense.amount.toCurrency(settings.locale))
                    Image(systemName: "chevron.right")
                }
                Divider()
                    .padding(.trailing, -16)
            }
        }
        .foregroundColor(.three)
    }
}

struct DummyExpense {
    let id = UUID()
    let amount: Double
    let date: Date
    let notes: String
    let budget: DummyBudget
}

struct ExpensesList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExpensesList(budgets: [
                DummyBudget(icon: "car.fill", name: "Transport", amountUsed: 1300000, amountTotal: 2000000, amountSaved: 1500000),
                DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 275000, amountTotal: 1700000, amountSaved: 500000),
                DummyBudget(icon: "house.fill", name: "Accommodation", amountUsed: 675000, amountTotal: 1850000, amountSaved: 800000),
                DummyBudget(icon: "car.fill", name: "Flight", amountUsed: 1300000, amountTotal: 2000000, amountSaved: 1500000),
                DummyBudget(icon: "leaf.fill", name: "Entertainment", amountUsed: 275000, amountTotal: 1700000, amountSaved: 500000),
                DummyBudget(icon: "house.fill", name: "Shopping", amountUsed: 675000, amountTotal: 1850000, amountSaved: 800000),
            ], expenses: [
                DummyExpense(amount: 50000, date: Date().addingTimeInterval(-2000), notes: "McD Korea",
                              budget: DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 1, amountTotal: 1, amountSaved: 1)),
                DummyExpense(amount: 2000000, date: Date().addingTimeInterval(-90000), notes: "Berangkat Ke Korea",
                              budget: DummyBudget(icon: "car.fill", name: "Transport", amountUsed: 1, amountTotal: 1, amountSaved: 1)),
                DummyExpense(amount: 1000000, date: Date().addingTimeInterval(-100000), notes: "Capsule Hotel Korea",
                              budget: DummyBudget(icon: "house.fill", name: "Accommodation", amountUsed: 1, amountTotal: 1, amountSaved: 1)),
            ]).environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
        }
    }
}
