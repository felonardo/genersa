//
//  ExpenseDataSource.swift
//  genersa
//
//  Created by Leo nardo on 01/11/21.
//

import Foundation

import CoreData

class ExpenseDataSource {
    
    static let shared = ExpenseDataSource()
    var expenses: [Expense] = []
    
    var container: NSPersistentContainer
    
    init() {
        container = PersistenceController.shared.container
    }
    
    func getExpense(with id: UUID) -> Expense? {
        return expenses.first(where: {$0.id == id})
    }
    
    func createExpense(amount: Double, date: Date, notes: String, budget: String) -> Expense{
        let newExpense = Expense(context: container.viewContext)
        newExpense.id = UUID()
        newExpense.amount = amount
        newExpense.date = date
        newExpense.notes = notes
        BudgetDataSource.shared.readBudgets()
        newExpense.budget = BudgetDataSource.shared.getBudget(name: budget)
        newExpense.budget!.amountUsed = newExpense.budget!.amountUsed + newExpense.amount
        expenses.append(newExpense)
        PersistenceController.shared.save()
        return newExpense
    }
    
    func readExpenses() -> Bool {
        
        let request = Expense.fetchRequest()
        do {
            expenses =  try container.viewContext.fetch(request)
            return true
        } catch {
            print("Error reading expenses. \(error.localizedDescription)")
            return false
        }
    }
    
    func updateExpense(id: UUID, amount: Double? = nil, title: String? = nil) -> Bool {
        
        if let expense = getExpense(with: id) {
            expense.amount = amount ?? expense.amount
            PersistenceController.shared.save()
            return true
        } else {
            print("Update expense failed. Expense with id (\(id)), not found")
            return false
        }
    }
    
    func deleteExpense(id: UUID) -> Bool {
        
        if let expense = getExpense(with: id) {
            container.viewContext.delete(expense)
            PersistenceController.shared.save()
            expenses.removeAll(where: {$0.id == id})
            return true
        } else {
            print("Delete expense failed. Expense with id (\(id)), not found")
            return false
        }
    }
}
