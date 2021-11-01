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
    var container: NSPersistentCloudKitContainer
    
    init() {
        container = PersistenceController.shared.container
    }
    
    func getExpense(with id: UUID) -> Expense? {
        return expenses.first(where: {$0.id == id})
    }
    
    func createExpense(amount: Double, isPayer: Bool,
                       isReceiver: Bool, budget: Budget, user: User,
                       title: String, notes: String, photoBill: Data) -> Expense {
        
        let newExpense = Expense(context: container.viewContext)
        newExpense.id = UUID()
        newExpense.amount = amount
        newExpense.notes = notes
        newExpense.title = title
        newExpense.photoBill = photoBill
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
            expense.title = title ?? expense.title
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
