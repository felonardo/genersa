//
//  ExpensesList.swift
//  genersa
//
//  Created by Joanda Febrian on 14/11/21.
//

import SwiftUI

struct ExpensesList: View {
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @FetchRequest(
        entity: Budget.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Budget.name, ascending: true)
        ]) var budgets: FetchedResults<Budget>
    
    @FetchRequest(
        entity: Expense.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Expense.date, ascending: false)
        ]) var expenses: FetchedResults<Expense>
    
    let recents: Bool
    
    @State var selectedBudget: String = ""
    
    init(recents: Bool = false) {
        self.recents = recents
    }
    
    var mappedExpenses: [Date:[Expense]] {
        var groupedExpenses = [Date:[Expense]]()
        for expense in expenses {
            if let date = expense.date {
                if groupedExpenses[date.dateOnly()] != nil {
                    groupedExpenses[date.dateOnly()]!.append(expense)
                } else {
                    groupedExpenses[date.dateOnly()] = [expense]
                }
            }
        }
        return groupedExpenses
    }
    
    var body: some View {
        if recents {
            VStack {
                ForEach(expenses.prefix(3), id: \.id) { expense in
                    NavigationLink(destination: ExpenseDetail(expense: expense)) {
                        ExpensesCell(expense: expense)
                            .background(RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(.customPrimary.opacity(0.1)))
                    }
                }
            }
        } else {
            ScrollView {
                LazyVStack {
                    BudgetSlider(selectedBudget: $selectedBudget)
                    ForEach(mappedExpenses.sorted(by: {$0.key > $1.key}), id: \.key) { key, value in
                        let filteredValue = value.filter {
                            if let name = $0.budget?.name {
                                return name.contains(selectedBudget) || selectedBudget == ""
                            }
                            return false
                        }
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
                NavigationLink(destination: ExpenseDetail(expense: expense)) {
                    ExpensesCell(expense: expense)
                        .background(RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.customPrimary.opacity(0.1)))
                }
            }
        }
    }
}

struct ExpensesCell: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    let expense: Expense
    
    var body: some View {
        HStack {
            if expense.budget != nil {
                Image(systemName: expense.budget!.icon!)
                    .padding(12)
                VStack(spacing: 8) {
                    HStack {
                        if let name = expense.budget?.name,
                           let date = expense.date,
                           let notes = expense.notes {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(notes)
                                Text(expense.amount.toCurrency(currency))
                                    .bold()
                            }

                            Spacer()
                            VStack(spacing: 4) {
                                Text(date.toString(withFormat: "HH.mm"))
                                HStack{
                                    Image(systemName: "person.fill")
                                    //TODO ganti pake amount user
                                    Text("1")
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(8)
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
