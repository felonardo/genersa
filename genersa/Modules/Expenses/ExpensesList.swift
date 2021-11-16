//
//  ExpensesList.swift
//  genersa
//
//  Created by Joanda Febrian on 14/11/21.
//

import SwiftUI

struct ExpensesList: View {
    
    @FetchRequest(
        entity: Budget.entity(),
        sortDescriptors: [
            
        ]) var budgets: FetchedResults<Budget>
    
    
    @FetchRequest(
        entity: Expense.entity(),
        sortDescriptors: [
            
        ]) var expenses: FetchedResults<Expense>
    
    let recents: Bool
    
    @State var selectedBudget: String = ""
    
    init(recents: Bool = false) {
        self.recents = recents
    }
    
    var mappedExpenses: [Date:[Expense]] {
        var groupedExpenses = [Date:[Expense]]()
        for expense in expenses {
            if groupedExpenses[expense.date!.dateOnly()] != nil {
                groupedExpenses[expense.date!.dateOnly()]!.append(expense)
            } else {
                groupedExpenses[expense.date!.dateOnly()] = [expense]
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
                    BudgetSlider(selectedBudget: $selectedBudget)
                    ForEach(mappedExpenses.sorted(by: {$0.key > $1.key}), id: \.key) { key, value in
                        let filteredValue = value.filter { $0.budget!.name!.contains(selectedBudget) || selectedBudget == "" }
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
    
    var expenses: [Expense]
    
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
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    let expense: Expense
    
    var body: some View {
        HStack {
            Image(systemName: expense.budget!.icon!)
                .padding(12)
            VStack(spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(expense.budget!.name!)
                            .bold()
                        HStack(spacing: 4) {
                            Text(expense.date!.toString(withFormat: "HH.mm"))
                            Text(expense.notes!)
                        }
                        .font(.caption)
                        .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(expense.amount.toCurrency(currency))
                    Image(systemName: "chevron.right")
                }
                Divider()
                    .padding(.trailing, -16)
            }
        }
        .foregroundColor(.three)
    }
}

struct ExpensesList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExpensesList()
        }
    }
}
